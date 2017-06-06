//
//  BannerItemView.h
//  lvling
//
//  Created by DaVinci Shen on 13-11-6.
//  Copyright (c) 2013年 juyuanqicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSImageView.h"

@interface BannerItemView : UIView{
    MSViewController *parent;
    NSDictionary *item;
}
@property (weak, nonatomic) IBOutlet MSImageView *imgBanner;

- (IBAction)actItemOpen:(id)sender;

- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController;

@end
