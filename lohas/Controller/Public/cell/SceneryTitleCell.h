//
//  SceneryTitleCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"
#import "EventBanner.h"

@interface SceneryTitleCell : MSTableViewCell{
    EventBanner *bannerView;
}

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnBooking;

- (IBAction)actFave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFave;

@property (weak, nonatomic) IBOutlet UIView *viewBanner;

@property(copy,nonatomic)NSDictionary *countryInfo;
@property(copy,nonatomic)NSDictionary *headDic;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labPriceTail;
@property (weak, nonatomic) IBOutlet UILabel *labComment;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;
- (IBAction)actGetPhoto:(id)sender;

@property(copy,nonatomic)NSArray *photoList;


@end
