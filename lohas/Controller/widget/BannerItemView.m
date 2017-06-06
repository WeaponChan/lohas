//
//  BannerItemView.m
//  lvling
//
//  Created by DaVinci Shen on 13-11-6.
//  Copyright (c) 2013年 juyuanqicheng. All rights reserved.
//

#import "BannerItemView.h"
#import "WapViewController.h"

@implementation BannerItemView
@synthesize imgBanner;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController
{
    
    parent = parentViewController;
    item = dict;
    
    NSString *imgurl = [item objectForKeyNotNull:@"image"];
    if(imgurl.length==0){
        imgurl=[item objectForKeyNotNull:@"picture"];
    }
    //imgBanner.showsLoadingActivity = true;
    imgBanner.autoresizeEnabled = false;
    [imgBanner loadImageAtURLString:imgurl placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
        
}

- (IBAction)actItemOpen:(id)sender {
    NSLog(@"actItemOpen");
    NSString *url=[item objectForKeyNotNull:@"url"];
    if (url.length==0) {
        return;
    }
    
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=url;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}
@end
