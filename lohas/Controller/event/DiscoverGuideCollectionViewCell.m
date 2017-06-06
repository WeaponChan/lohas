//
//  DiscoverGuideCollectionViewCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/26.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverGuideCollectionViewCell.h"
#import "DiscoverDetailViewController.h"

@implementation DiscoverGuideCollectionViewCell{
    NSDictionary *itemDic;
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
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DiscoverGuideCollectionViewCell" owner:self options:nil];
        
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
    parent=parentCtrl;
    
    NSString *pics=[itemData objectForKeyNotNull:@"pics"];
    
    NSArray *picList=[pics componentsSeparatedByString:@","];
    NSString *image;
    if (picList.count>0) {
        image=picList[0];
    }else{
        
        image=pics;
    }
    
    [self.imageHead setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageHead.contentMode =  UIViewContentModeScaleAspectFill;
   // self.imageHead.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageHead.clipsToBounds  = YES;
    
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg200x200.png"]];
    
    self.labName.text=[itemDic objectForKeyNotNull:@"title"];

}

- (IBAction)actClick:(id)sender {
    
    DiscoverDetailViewController *viewCtrl=[[DiscoverDetailViewController alloc]initWithNibName:@"DiscoverDetailViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.detailID=[itemDic objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}
@end
