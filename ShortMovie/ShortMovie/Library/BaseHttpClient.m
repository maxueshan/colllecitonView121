//
//  BaseHttpClient.m
//  LoveLimiteFree
//
//  Created by Elean on 16/5/11.
//  Copyright © 2016年 Elean. All rights reserved.
//

#import "BaseHttpClient.h"



@implementation BaseHttpClient

#pragma mark -- 自定义构造方法
- (instancetype)initWithBaseUrl:(NSString *)baseUrl{
    
//baseUrl：如果应用程序中所有接口都来自于同一个服务器 服务器地址都是一样的 为了请求接口的统一 可以用baseUrl表示相同的服务器地址
    
//另外：实际开发中 服务器有可能分为测试服务器和正式服务器 两个服务器两套地址 方便程序可以用于测试服务器以及正式服务器上的测试
    
    self = [super init];
    
    if (self) {
        
        //创建 manager 并且设置
        
        _manager = [AFHTTPSessionManager manager];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        
        _baseURL = baseUrl;
        //记录服务器地址 如果app中是多台服务器 baseUrl可以直接传 @""
        
    }
    
    return self;
    
}

#pragma mark -- 单例方法
+ (BaseHttpClient *)sharedBaseHttpClient{

    static BaseHttpClient *sharaClient = nil;
    
    //只执行一次的代码 写在block内部
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     
        //创建单例对象时 同时创建其内部的属性manager
        //目的是为了单例对象一旦创建 就能存在manager用于网络请求
        sharaClient = [[BaseHttpClient alloc]initWithBaseUrl:@""];
        //参数 是服务器地址 RequestAPI中
        
        
    });
    
    
    return sharaClient;
    
    
    
}



#pragma mark -- 公共请求方法
+ (NSURL *)requestWithHttpType:(HTTP_TYPE)type andParameters:(NSDictionary *)parameters andURL:(NSString *)url andSucBlock:(HttpSucBlock)sucBlock andFailBlock:(HttpFailBlock)failBlock{
    
    
   
    if(type == GET){
    
        return [BaseHttpClient GETWithParameters:parameters andURL:url andSucBlock:sucBlock andFailBlock:failBlock];
        
    }else if (type == POST){
    
    
        return [BaseHttpClient POSTWithParameters:parameters andURL:url andSucBlock:sucBlock andFailBlock:failBlock];
        
    }
    
    

    
    return nil;
}

#pragma mark -- GET请求
+ (NSURL *)GETWithParameters:(NSDictionary *)parameters andURL:(NSString *)url andSucBlock:(HttpSucBlock)sucBlock andFailBlock:(HttpFailBlock)failBlock{
    //拼接地址 发起请求 触发block
    
//提示框
//    [MMProgressHUD showWithStatus:@"loading..."];
//    
//    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    //1.拼接地址
    
    //(1)创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //(2)拼接地址 服务器地址（baseURL）+ 目标文件路径（url）
    NSString *URL = [NSString stringWithFormat:@"%@%@",client.baseURL, url];
    
    //如果地址中出现特殊字符 需要先将地址进行合法化处理 避免发生网络地址无法访问的问题
    
    //有一些接口 合法化后 反而不能请求 解决方法1：利用正则表达式判断当前url是否包含非法字符 解决方法2：如果代码无法请求 但是浏览器中正常请求 直接将合法化代码注释
    URL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
// iOS9弃用   [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    
    
    //(3)转换为NSURL 用于返回
    NSURL *returnURL = [NSURL URLWithString:URL];
    
    //2.发起请求 单例对象manager属性
    [client.manager GET:URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //请求成功
        //(1)json解析 obj是数组或者字典
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//提示框
        [MMProgressHUD dismissWithSuccess:@"加载成功!!!"];
        
    
        //(2)判断请求数据是否为空
        
        //【注意】由于数据的回调 是与控制器上的UI相关 因此应该放到主队列中（只有一个主线程）执行
        dispatch_async(dispatch_get_main_queue(), ^{
           

            sucBlock(obj, returnURL);
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //请求失败
//提示框
[MMProgressHUD dismissWithError:@"哦NO! 加载失败!"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            failBlock(returnURL, error);
            
        });
        
        
    }];
    
    
    
    
    

    return returnURL;
}

#pragma mark -- POST请求
+ (NSURL *)POSTWithParameters:(NSDictionary *)parameters andURL:(NSString *)url andSucBlock:(HttpSucBlock)sucBlock andFailBlock:(HttpFailBlock)failBlock{
    //拼接地址 发起请求 触发block
    
    //1.拼接地址
    
    //(1)创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //(2)拼接地址 服务器地址（baseURL）+ 目标文件路径（url）
    NSString *URL = [NSString stringWithFormat:@"%@%@",client.baseURL, url];
    
    //如果地址中出现特殊字符 需要先将地址进行合法化处理 避免发生网络地址无法访问的问题
    
    //有一些接口 合法化后 反而不能请求 解决方法1：利用正则表达式判断当前url是否包含非法字符 解决方法2：如果代码无法请求 但是浏览器中正常请求 直接将合法化代码注释
    URL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // iOS9弃用   [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    
    
    //(3)转换为NSURL 用于返回
    NSURL *returnURL = [NSURL URLWithString:URL];
    
    //2.发起请求 单例对象manager属性
    [client.manager POST:URL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        //请求成功
        //(1)json解析 obj是数组或者字典
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //(2)判断请求数据是否为空
        
        //【注意】由于数据的回调 是与控制器上的UI相关 因此应该放到主队列中（只有一个主线程）执行
        dispatch_async(dispatch_get_main_queue(), ^{
            
            sucBlock(obj, returnURL);
        });
        
    
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //请求失败
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failBlock(returnURL, error);
            
        });
        
        
    }];
    
    
    
    
    return returnURL;


}

@end







