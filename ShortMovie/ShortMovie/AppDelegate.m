//
//  AppDelegate.m
//  ShortMovie
//
//  Created by MS on 16-5-31.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[MainViewController alloc]init];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    
    
    
    [self monitorNetworkStatus];
    //循环检测网络状态

    return YES;
}
#pragma mark - 循环检测网络连接状态

-(void)monitorNetworkStatus
{
    //1. 创建对象 通过不断的去请求百度的地址来检测网络状态
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    //2. 注册通知 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    //3. 开始监听 如果网络状态发生变化 则触发通知方法
    [reach startNotifier];
    
    
}

#pragma mark -- 网络状态改变触发的通知方法
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        NSLog(@"Notification Says Reachable");
    }
    else
    {
        NSLog(@"Notification Says Unreachable");
        [self showNoticeMsg:@"无网络连接，请检查网络" WithInterval:2.0f];
    }
}
#pragma mark - 全局提示信息

//提示网络状态（不带block）
-(void)showNoticeMsg:(NSString *)msg WithInterval:(float)timer
{
    [AJNotificationView showNoticeInView:self.window
                                    type:AJNotificationTypeBlue
                                   title:msg
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:timer
                                response:^{
                                    // NSLog(@"Response block");
                                }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
