//
//  JingPinTableViewCell.h
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JingPinModel.h"

@interface JingPinTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *xingLabel;

@property (strong, nonatomic) IBOutlet UILabel *collectLabel;


- (void)loadDataFromJPModel:(JingPinModel *)model;

@end
