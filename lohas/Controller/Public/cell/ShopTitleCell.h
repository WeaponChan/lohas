//
//  ShopTitleCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "EventBanner.h"
#import "MSButtonToAction.h"

@interface ShopTitleCell : MSTableViewCell{
    EventBanner *bannerView;
}

@property BOOL isDestination;
@property (weak, nonatomic) IBOutlet UILabel *labMainTitle;

@property (weak, nonatomic) IBOutlet UIView *viewBanner;

@property (weak, nonatomic) IBOutlet UIButton *btnFav;
- (IBAction)actFav:(id)sender;

@property(copy,nonatomic)NSDictionary *resItem;
@property(copy,nonatomic)NSDictionary *infoItem;

@property (weak, nonatomic) IBOutlet UILabel *labTItle;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labDes;
@property (weak, nonatomic) IBOutlet UILabel *labComment;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;

- (IBAction)actGetPhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnBooking;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labPriceTail;

@end
