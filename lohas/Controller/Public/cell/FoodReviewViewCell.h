//
//  ReviewViewCell.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface FoodReviewViewCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

- (IBAction)actImageHead:(id)sender;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labScore;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageSex;
@property (weak, nonatomic) IBOutlet UILabel *labPingFen;

@end
