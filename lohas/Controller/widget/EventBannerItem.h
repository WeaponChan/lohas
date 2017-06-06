//
//  EventBannerItem.h
//  lohas
//
//  Created by fred on 15-4-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface EventBannerItem : UIView{
    MSViewController *parent;
    NSDictionary *item;
}
@property (weak, nonatomic) IBOutlet MSImageView *imgBanner;

- (IBAction)actItemOpen:(id)sender;

- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSArray *picList;

@end
