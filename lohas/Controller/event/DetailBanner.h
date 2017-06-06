//
//  DetailBanner.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSButtonToAction.h"

@interface DetailBanner : UIView<UIScrollViewDelegate>{
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
