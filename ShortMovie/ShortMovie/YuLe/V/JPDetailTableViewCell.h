//
//  JPDetailTableViewCell.h
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JPDetailModel.h"

@interface JPDetailTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *cateLabel;


@property (strong, nonatomic) IBOutlet UILabel *desLabel;


- (void)loadDataFromDetailModel:(JPDetailModel *)model;

@end
