//
//  BaseViewController.h
//  ShortMovie
//
//  Created by MS on 16-5-31.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString *url;

- (void)initData;
- (void)setMyUrl;


@end
