//
//  HotelTitleCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"
#import "EventBanner.h"

@interface HotelTitleCell : MSTableViewCell{
    EventBanner *bannerView;
}

@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSDictionary *ListItem;

@property (weak, nonatomic) IBOutlet UIView *viewBanner;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labCommentNum;
@property (weak, nonatomic) IBOutlet UILabel *labF;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labTag;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnOrder;

@property (weak, nonatomic) IBOutlet UIButton *btnFave;
- (IBAction)actFave:(id)sender;

@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;

- (IBAction)actGetPhoto:(id)sender;

@end
