//
//  HotelRoomCell.m
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelRoomCell.h"

@implementation HotelRoomCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=[item objectForKeyNotNull:@"room_title"];
    self.labDes.text=[NSString stringWithFormat:@"描述:%@",[item objectForKeyNotNull:@"room_desc"]];
    
    NSString *room_price=[item objectForKeyNotNull:@"room_price"];
    self.labPrice.text=[NSString stringWithFormat:@"￥%@",room_price];
    
    NSString *image=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg80x80.png"]];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 80;
}

@end
