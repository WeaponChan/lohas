//
//  DynamicCollectionViewCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicCollectionViewCell.h"
#import "DynamicDetailViewController.h"

@implementation DynamicCollectionViewCell{
    NSDictionary *itemDic;
    MSViewController *parent;
    
    BOOL isFirstIn;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DynamicCollectionViewCell" owner:self options:nil];
        
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
    
    NSString *image=[itemData objectForKeyNotNull:@"image"];
    if (image.length==0) {
        image=[itemData objectForKeyNotNull:@"picture"];
    }
    
    [self.imageHead setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageHead.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageHead.clipsToBounds  = YES;
    
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    
   /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // switch to a background thread and perform your expensive operation
        UIImage *image1=[parent getImageFromURL:image];
        UIImage *rectImage=[parent cutImage:image1 imageView:self.imageHead];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // switch back to the main thread to update your UI
            self.imageHead.image=rectImage;
        });
        
    });*/
    
    
    

    
    
}

- (IBAction)actClick:(id)sender {
    
    if (![parent isLogin]) {
        [parent presentToLoginView:parent];
        return;
    }
    
    DynamicDetailViewController *viewCtrl=[[DynamicDetailViewController alloc]initWithNibName:@"DynamicDetailViewController" bundle:nil];
    viewCtrl.dynamicID=[itemDic objectForKeyNotNull:@"id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end
