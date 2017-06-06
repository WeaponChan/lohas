//
//  EventBanner.m
//  lohas
//
//  Created by fred on 15-4-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventBanner.h"
#import "EventBannerItem.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation EventBanner{
    NSArray *picList;
}
@synthesize pageCtrl,scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initial:(MSViewController*)parentViewController{
    parent = parentViewController;
    
    dataList = [[NSMutableArray alloc] init];
    
    //    [self.btnBannerLeft setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2ALPHA];
    //    [self.btnBannerLeft addBtnAction:@selector(scropToLeft) target:self];
    //
    //    [self.btnBannerRight setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2ALPHA];
    //    [self.btnBannerRight addBtnAction:@selector(scropToRight) target:self];
    
}

- (void)scropToLeft{
    //    [self.self.btnBannerLeft setEnabled:false];
    [self setScrollViewPage:(currentPage-1) animated:true];}

- (void)scropToRight{
    //    [self.self.btnBannerRight setEnabled:false];
    [self setScrollViewPage:(currentPage+1) animated:true];
}

-(void)reload:(NSArray*)response
{
    NSLog(@"BannerView reload:%@",response);
    picList=response;
    
    //pageWidth = scrollView.frame.size.width;
    pageWidth = SCREENWIDTH;
    pageHeight = scrollView.frame.size.height;
    
    [dataList removeAllObjects];
    
    if(response && [response isKindOfClass:[NSArray class]]) {
        int count = response.count;
        if (count>=2) {
            [dataList addObject:[response objectAtIndex:(count-2)]];
            [dataList addObject:[response objectAtIndex:(count-1)]];
            [dataList addObjectsFromArray:response];
            [dataList addObject:[response objectAtIndex:(0)]];
            [dataList addObject:[response objectAtIndex:(1)]];
            
            [self initScroll];
            [self initTimer];
            [self setScrollViewPage:2 animated:false];
            
        }else{
            dataList =(NSMutableArray*)response;
            [self initScroll];
            [self initTimer];
            [self setScrollViewPage:0 animated:false];
        }
        [pageCtrl setNumberOfPages:count];
    }
    
}

//初始化UIScrollView
- (void)initScroll
{
    //pageWidth = scrollView.frame.size.width;
    pageWidth = SCREENWIDTH;
    pageHeight = scrollView.frame.size.height;
    
    int count = [dataList count];
    
    NSArray* sbs = [scrollView subviews];
    for(UIView* subview in sbs) {
        [subview removeFromSuperview];
    }
    
    //创建bannerView
    for (int i=0; i<count; i++) {
        NSDictionary* dict = [dataList objectAtIndex:i];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventBannerItem" owner:self options: nil];
        EventBannerItem *view = (EventBannerItem *)[nib objectAtIndex: 0];
        view.picList=picList;
        [view update:dict Parent:parent];
        
        view.frame = CGRectMake(pageWidth*i, 0, scrollView.frame.size.width, pageHeight);
        [scrollView addSubview:view];
    }
    scrollView.contentSize = CGSizeMake(pageWidth * count, pageHeight);
    scrollView.delegate = self;
    
}

//定时器
-(void)initTimer
{
    //时间间隔
    NSTimeInterval timeInterval = 10.0 ;
    if(showTimer) {
        [showTimer invalidate];
        showTimer = nil;
    }
    //定时器
    showTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                 target:self
                                               selector:@selector(handleShowTimer:)
                                               userInfo:nil
                                                repeats:true];
}

//触发事件
-(void)handleShowTimer:(NSTimer *)theTimer
{
    int page = currentPage + 1;
    if (page >= dataList.count) {
        page = 0;
    }
    [self setScrollViewPage:page animated:true];
}

- (void)setScrollViewPage:(int)page animated:(BOOL)animated{
    CGPoint offset = CGPointMake(pageWidth*page, 0);
    [scrollView setContentOffset:offset animated:animated];
}

//UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (currentPage != page) {
        currentPage = page;
        [pageCtrl setCurrentPage:currentPage-2];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender{
    //    NSLog(@"------------------------------------------------------------------");
    //    NSLog(@"scrollViewDidEndDecelerating pageCtrl.currentPage:%d",pageCtrl.currentPage);
    //    NSLog(@"scrollViewDidEndDecelerating currentPage:%d",currentPage);
    //    NSLog(@"------------------------------------------------------------------");
    
    if (currentPage == 1) {
        [self setScrollViewPage:(dataList.count-3) animated:false];
    }else if (currentPage == dataList.count-2){
        [self setScrollViewPage:2 animated:false];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //    NSLog(@"------------------------------------------------------------------");
    //    NSLog(@"scrollViewDidEndScrollingAnimation pageCtrl.currentPage:%d",pageCtrl.currentPage);
    //    NSLog(@"scrollViewDidEndScrollingAnimation currentPage:%d",currentPage);
    //    NSLog(@"------------------------------------------------------------------");
    
    if (currentPage == 1) {
        [self setScrollViewPage:(dataList.count-3) animated:false];
    }else if (currentPage == dataList.count-2){
        [self setScrollViewPage:2 animated:false];
    }
    //    [self.btnBannerLeft setEnabled:true];
    //    [self.btnBannerRight setEnabled:true];
}


@end
