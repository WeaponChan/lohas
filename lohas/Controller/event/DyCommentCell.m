//
//  DyCommentCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DyCommentCell.h"
#import "MSViewController.h"
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation DyCommentCell

-(void)updateInfo:(NSDictionary*)diction{
    
    self.labName.text=[NSString stringWithFormat:@"%@:",[diction objectForKey:@"nick"]];
    self.labComment.text=[diction objectForKey:@"content"];
    
    [self.labName sizeToFit];
    int width=self.labName.frame.size.width;
    [MSViewFrameUtil setLeft:10+width+5 UI:self.labComment];
    [MSViewFrameUtil setWidth:SCREENWIDTH-(10+width+5+10) UI:self.labComment];
    [self.labComment sizeToFit];
    int height = self.labComment.frame.size.height;
    
    [MSViewFrameUtil setHeight:5+height+5 UI:self];
    
}

@end
