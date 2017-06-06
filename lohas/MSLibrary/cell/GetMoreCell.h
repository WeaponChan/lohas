//
//  GetMoreCell.h
//  bbs4iphone
//
//  Created by xmload shen on 11-11-4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labMoreTips;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *aivLoading;
@property (strong, nonatomic) IBOutlet UIImageView *sepImage;

- (void)ShowLoading;
- (void)HiddenLoading;

- (void)update:(NSString *)title;
- (void)update:(NSString *)title hiddenSepImage:(BOOL)hidden;
+ (int)Height;

@end
