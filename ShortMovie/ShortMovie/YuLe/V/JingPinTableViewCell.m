//
//  JingPinTableViewCell.m
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "JingPinTableViewCell.h"

@implementation JingPinTableViewCell


- (void)loadDataFromJPModel:(JingPinModel *)model{
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"bg"]];
    self.titleLabel.text = model.title;
    self.xingLabel.text = model.rating;
    self.collectLabel.text = model.share_num;
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
