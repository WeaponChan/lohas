//
//  PhotoGetMoreCell.m
//  lohas
//
//  Created by fred on 15-4-23.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "PhotoGetMoreCell.h"
#import "PhotoShowViewController.h"
#import "DynamicViewController.h"
#import "DynamicUserInfoViewController.h"
#import "NewUserViewController.h"

@implementation PhotoGetMoreCell{
    MSViewController *parent;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PhotoGetMoreCell" owner:self options:nil];
        
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

-(void)updateCell:(MSViewController*)parentCtrl item:(NSDictionary*)item{
    parent=parentCtrl;
    
    NSString *image=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
}

//获取更多
- (IBAction)actGetMore:(id)sender {
    
    
    if ([parent isKindOfClass:[PhotoShowViewController class]]) {
        PhotoShowViewController *viewCtrl=(PhotoShowViewController*)parent;
        [viewCtrl getMorePhoto];
    }
    else if ([parent isKindOfClass:[DynamicViewController class]]){
        DynamicViewController *viewCtrl=(DynamicViewController*)parent;
        [viewCtrl getMore];
    }
    else if ([parent isKindOfClass:[DynamicUserInfoViewController class]]){
        DynamicUserInfoViewController *viewCtrl=(DynamicUserInfoViewController*)parent;
        [viewCtrl getMore];
    }
    else if ([parent isKindOfClass:[NewUserViewController class]]){
        NewUserViewController *viewCtrl=(NewUserViewController*)parent;
        [viewCtrl getMore];
    }
}

@end
