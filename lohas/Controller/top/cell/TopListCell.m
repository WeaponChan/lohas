//
//  TopListCell.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "TopListCell.h"
#import "TopViewController.h"

@implementation TopListCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    [self.btnClick setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnClick addBtnAction:@selector(actClick) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    self.labsubTitle.text=[item objectForKeyNotNull:@"desc"];
    
    NSString *image=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
//    [self.labsubTitle sizeToFit];
//    int height = self.labsubTitle.frame.size.height;
//    [MSViewFrameUtil setHeight:25+height+5 UI:self.viewInfo];
    
}

-(void)actClick{
    TopViewController *viewCtrl=[[TopViewController alloc]initWithNibName:@"TopViewController" bundle:nil];
    viewCtrl.subID=[item objectForKeyNotNull:@"id"];
    viewCtrl.headDic=item;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

+ (int)Height:(NSDictionary *)itemData{
    
    NSString*desc =[itemData objectForKeyNotNull:@"desc"];
    
    int height = [MSViewFrameUtil getLabHeight:desc FontSize:12 Width:300];
    
    return 200;
}


@end
