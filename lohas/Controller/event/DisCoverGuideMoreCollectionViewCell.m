//
//  DisCoverGuideMoreCollectionViewCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DisCoverGuideMoreCollectionViewCell.h"
#import "DiscoverViewController.h"

@implementation DisCoverGuideMoreCollectionViewCell{
    MSViewController *parent;
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DisCoverGuideMoreCollectionViewCell" owner:self options:nil];
        
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
}

//获取更多
- (IBAction)actGetMore:(id)sender {
    
    if ([parent isKindOfClass:[DisCoverGuideMoreCollectionViewCell class]]) {
        
    }
    
}

@end
