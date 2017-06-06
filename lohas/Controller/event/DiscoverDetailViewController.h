//
//  DiscoverDetailViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DetailBanner.h"

@interface DiscoverDetailViewController : MainViewController{
    DetailBanner *bannerView;
   
}

@property(copy,nonatomic)NSString *detailID;
@property (weak, nonatomic) IBOutlet UIView *viewBanner;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *labTitleTag;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
