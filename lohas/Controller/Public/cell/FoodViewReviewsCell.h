//
//  FoodViewReviewsCell.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "GrayBorderView.h"

@interface FoodViewReviewsCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

@property(copy,nonatomic)NSDictionary *comment_numDic;
@property(copy,nonatomic)NSDictionary *infoDic;
@property(copy,nonatomic)NSDictionary *headDic;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;

@property (weak, nonatomic) IBOutlet UILabel *labComment;
@property (weak, nonatomic) IBOutlet UIView *labLine1;
@property (weak, nonatomic) IBOutlet UIView *labLine2;
@property (weak, nonatomic) IBOutlet UIView *labLine3;
@property (weak, nonatomic) IBOutlet UIView *labLine4;
@property (weak, nonatomic) IBOutlet UILabel *labNum1;
@property (weak, nonatomic) IBOutlet UILabel *labNum2;
@property (weak, nonatomic) IBOutlet UILabel *labNum3;
@property (weak, nonatomic) IBOutlet UILabel *labNum4;

@property (weak, nonatomic) IBOutlet GrayBorderView *viewGray;


@end
