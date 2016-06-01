//
//  MainViewController.m
//  ShortMovie
//
//  Created by MS on 16-5-31.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "MainViewController.h"

#import "YuLeViewController.h"
#import "JingPinViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createControllers];
    
}

- (void)createControllers{
    YuLeViewController *yuleVC = [[YuLeViewController alloc]init];
    JingPinViewController *jingpinVC = [[JingPinViewController alloc]init];
    NSArray *arrVC = @[yuleVC,jingpinVC];
    NSArray *titleArr = @[@"娱乐",@"精品"];
    NSArray *imgArr = @[@"我的",@"我的"];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i<arrVC.count; i++) {
        UIViewController *vc = arrVC[i];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        
        vc.title = titleArr[i];
        UIImage *image = [UIImage imageNamed:imgArr[i]];
        vc.tabBarItem.image = image;
        vc.tabBarItem.selectedImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [arrM addObject:nav];
        
    }
    
    self.viewControllers = arrM;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
