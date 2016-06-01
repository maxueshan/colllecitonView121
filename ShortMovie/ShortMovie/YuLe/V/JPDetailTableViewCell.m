//
//  JPDetailTableViewCell.m
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "JPDetailTableViewCell.h"

@implementation JPDetailTableViewCell


- (void)loadDataFromDetailModel:(JPDetailModel *)model{
    
    self.titleLabel.text = model.title;
    self.desLabel.text = model.content;
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
