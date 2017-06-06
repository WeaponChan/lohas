//
//  PhotoCell.m
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "PhotoCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation PhotoCell{
    NSDictionary *itemDic;
    NSString *index;
}
@synthesize photoList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];

    }
    return self;
}

-(void)updateCell:(MSViewController*)parentCtrl itemData:(NSDictionary*)itemData{
    
    itemDic=itemData;
    
    NSString *image=[itemData objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    
    index=[itemData objectForKeyNotNull:@"index"];
}

- (IBAction)actImage:(id)sender {
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: photoList.count];
    
   
        // 替换为中等尺寸图片
    for (NSDictionary *dic in photoList) {
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [dic objectForKeyNotNull:@"image"]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        MSImageView *img=[[MSImageView alloc]init];
        [img loadImageAtURLString:getImageStrUrl placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
        
        photo.srcImageView = img;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index.intValue; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

@end
