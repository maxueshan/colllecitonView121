//
//  YuLeViewController.m
//  ShortMovie
//
//  Created by MS on 16-5-31.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "YuLeViewController.h"

#import "DonghuaViewController.h"
#import "DongZuoViewController.h"
#import "MingXingViewController.h"
#import "PeiYinViewController.h"
#import "MVViewController.h"




@interface YuLeViewController ()

@end

@implementation YuLeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self createControllers];

    
}

- (void)createControllers{
    DonghuaViewController *donghuaVC = [[DonghuaViewController alloc]init];
    donghuaVC.title = @"动画";
    DongZuoViewController *dongzuoVC = [[DongZuoViewController alloc]init];
    dongzuoVC.title = @"动作";
    MingXingViewController *mingVC = [[MingXingViewController alloc]init];
    mingVC.title = @"明星";
    PeiYinViewController *peiyinVC = [[PeiYinViewController alloc]init];
    peiyinVC.title = @"配音";
    MVViewController *mvVC = [[MVViewController alloc]init];
    mvVC.title = @"MV";
    
    SCNavTabBarController *scNav = [[SCNavTabBarController alloc]init];
    scNav.subViewControllers = @[donghuaVC,dongzuoVC,mingVC,peiyinVC,mvVC];
    
    scNav.navTabBarColor = [UIColor redColor];
    
    [scNav addParentController:self];
    
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
