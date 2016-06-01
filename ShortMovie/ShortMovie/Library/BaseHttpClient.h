//
//  BaseHttpClient.h
//  LoveLimiteFree
//
//  Created by Elean on 16/5/11.
//  Copyright © 2016年 Elean. All rights reserved.
//
/*
 当前类 是对AFNetworking的第一次封装
 将不同的请求方式封装出一个公用的接口
 在封装的方法内部 对请求到的数据做出解析判断等处理
 
 将该类设计为一个单例类 存在一个SessionManager属性用于网络的请求
 
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//1.请求方式的枚举
typedef enum{

    GET = 1,
    POST,
    
}HTTP_TYPE;
//外部传入对应的枚举 内部方法可以区分应该调用哪一种请求方法

//2.定义两个Blockd的类型
//(1)成功回调 返回的数据id（数组或者字典）url(请求的地址)
typedef void(^HttpSucBlock)(id data, NSURL *url);

//(2)失败回调 返回的数据url(请求的地址) error(失败错误信息)
typedef void(^HttpFailBlock)(NSURL *url, NSError *error);


@interface BaseHttpClient : NSObject
//3.属性的抽象 需要一个AFNetworking中manager进行网络请求
@property (nonatomic,strong,readonly)AFHTTPSessionManager *manager;
//用于网络请求 只能读 不能写


@property (nonatomic,copy,readonly)NSString *baseURL;
//记录服务器地址 只能读 不能写


//4.方法的抽象
//(1)公共请求方法 所有的请求方式只需要一个接口

+ (NSURL *)requestWithHttpType:(HTTP_TYPE)type andParameters:(NSDictionary *)parameters andURL:(NSString *)url andSucBlock:(HttpSucBlock)sucBlock andFailBlock:(HttpFailBlock)failBlock;
/*
 type:请求的类型
 parameters:接口的参数
 url:请求的地址
 sucBlock:成功时回调的block
 failBlock:失败时回调的block
 */



//(3)单例方法
+ (BaseHttpClient *)sharedBaseHttpClient;



@end









