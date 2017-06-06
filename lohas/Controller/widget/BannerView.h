//
//  BannerView.h
//  lvling
//
//  Created by DaVinci Shen on 13-11-6.
//  Copyright (c) 2013年 juyuanqicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSButtonToAction.h"

@interface BannerView : UIView<UIScrollViewDelegate>{
    MSViewController *parent;
    NSMutableArray *dataList;
    UIActivityIndicatorView *indicatorView;
    NSTimer *showTimer;
    CGFloat pageWidth;
    CGFloat pageHeight;
    int currentPage;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

-(void) initial:(MSViewController*)parentViewController;
-(void) reload:(NSArray*)response;

@end
