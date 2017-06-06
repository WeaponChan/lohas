//
//  DetailBannerItem.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSImageView.h"

@interface DetailBannerItem : UIView{
    MSViewController *parent;
    NSDictionary *item;
}
@property (weak, nonatomic) IBOutlet MSImageView *imgBanner;

- (IBAction)actItemOpen:(id)sender;

- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController;

@end
