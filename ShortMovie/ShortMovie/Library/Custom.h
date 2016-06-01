//
//  Custom.h
//  PostImage
//
//  Created by MS on 16-4-27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Custom : NSObject


+ (void)showAlerWithController:(UIViewController *)ctrView andTitle:(NSString *)title andMessage:(NSString *)message  andTime:(NSTimeInterval)time;

@end
