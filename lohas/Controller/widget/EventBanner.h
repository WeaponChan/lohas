//
//  EventBanner.h
//  lohas
//
//  Created by fred on 15-4-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface EventBanner : UIView<UIScrollViewDelegate>{
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
