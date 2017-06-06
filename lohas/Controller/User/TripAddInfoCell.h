//
//  TripAddInfoCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface TripAddInfoCell : MSTableViewCell

@property(retain,nonatomic)NSMutableArray *selectList;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labComment;
@property (weak, nonatomic) IBOutlet UILabel *labName;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;

@property (weak, nonatomic) IBOutlet UILabel *labf;
@property (weak, nonatomic) IBOutlet UILabel *labPeople;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

- (IBAction)actSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;

@end
