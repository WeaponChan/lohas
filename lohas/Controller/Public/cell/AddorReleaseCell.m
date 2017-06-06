//
//  AddorReleaseCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/14.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "AddorReleaseCell.h"
#import "PhotoGetMoreCell.h"
#import "PhotoShowViewController.h"
#import "DynamicViewController.h"
#import "DynamicUserInfoViewController.h"
#import "PubishDynamicViewController.h"

@implementation AddorReleaseCell{
    MSViewController *parent;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"AddorReleaseCell" owner:self options:nil];
        
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


- (IBAction)actAdd:(id)sender {
    
    PubishDynamicViewController *ViewCtrl = [[PubishDynamicViewController alloc] init];
    ViewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:ViewCtrl animated:YES];
    
}
@end
