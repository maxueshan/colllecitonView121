//
//  JPDetailModel.h
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPDetailModel : NSObject

@property(nonatomic,copy)NSString *postid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *image;

@property(nonatomic,strong)NSDictionary *download_link;


//postid : "48953"
//title : "精美笔触神脑洞动画《祖母》"
//is_collect : 0
//content : "本片由比利时动画电影人Karolien Raeymaekers创作，以脑洞大开的画面勾勒出一个小女孩内心深处的恐惧。 在祖母的临终病房里，小女孩不得不直面死亡，然而在一个孩子心中，死亡实在是个太抽象的概念。于是，当她回望过去时，那些田园牧"
//image : "http://cs.vmoiver.com/Uploads/cover/2016-04-29/57233528834ea_cut.jpeg"
//duration : "450"
@end
