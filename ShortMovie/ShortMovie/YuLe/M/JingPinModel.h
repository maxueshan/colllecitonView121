//
//  JingPinModel.h
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JingPinModel : NSObject

@property(nonatomic,copy)NSString *postid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSNumber *is_xpc;
@property(nonatomic,strong)NSNumber *is_promote;
@property(nonatomic,strong)NSNumber *is_xpc_zp;
@property(nonatomic,strong)NSNumber *is_xpc_cp;
@property(nonatomic,strong)NSNumber *is_xpc_fx;
@property(nonatomic,strong)NSNumber *recent_hot;
@property(nonatomic,strong)NSNumber *discussion;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *rating;
@property(nonatomic,copy)NSString *duration;
@property(nonatomic,copy)NSString *publish_time;
@property(nonatomic,copy)NSString *like_num;
@property(nonatomic,copy)NSString *share_num;


//postid : "48981"
//title : "超精致梦幻水彩动画《我们需要谈谈爱丽丝》"
//is_xpc : 0
//is_promote : 0
//is_xpc_zp : 0
//is_xpc_cp : 0
//is_xpc_fx : 0
//recent_hot : 0
//discussion : 0
//image : "http://cs.vmoiver.com/Uploads/cover/2016-05-05/572b1580dff68_cut.jpeg"
//rating : "7.9"
//duration : "217"
//publish_time : "1463184180"
//like_num : "188"
//share_num : "115"

@end
