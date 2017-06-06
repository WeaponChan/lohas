//
//  EventBannerItem.m
//  lohas
//
//  Created by fred on 15-4-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventBannerItem.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation EventBannerItem
@synthesize imgBanner,picList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController
{    
    parent = parentViewController;
    item = dict;
    
    NSString *imgurl = [item objectForKeyNotNull:@"image"];
    //imgBanner.showsLoadingActivity = true;
    imgBanner.autoresizeEnabled = false;
    [imgBanner loadImageAtURLString:imgurl placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
}

- (IBAction)actItemOpen:(id)sender {
    NSLog(@"actItemOpen");
    
    return;
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: picList.count];
    
    // 替换为中等尺寸图片
    for (NSDictionary *dic in picList) {
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [dic objectForKeyNotNull:@"image"]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        MSImageView *img=[[MSImageView alloc]init];
        [img loadImageAtURLString:getImageStrUrl placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
        
        photo.srcImageView = img;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    NSString *index=[item objectForKeyNotNull:@"index"];
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index.intValue ; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

@end
