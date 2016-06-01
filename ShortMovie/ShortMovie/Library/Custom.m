//
//  Custom.m
//  PostImage
//
//  Created by MS on 16-4-27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "Custom.h"

@implementation Custom


+ (void)showAlerWithController:(UIViewController *)ctrView andTitle:(NSString *)title andMessage:(NSString *)message  andTime:(NSTimeInterval)time{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [ctrView presentViewController:alertC animated:YES completion:nil];
    
    [self performSelector:@selector(dismissC:) withObject:alertC afterDelay:time];
    
    
}


+ (void)dismissC:(UIAlertController *)alertC{
    
    [alertC dismissViewControllerAnimated:YES completion:nil];
    
}











@end
