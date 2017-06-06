//
//  NewTabHotCityCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface NewTabHotCityCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *labTtile1;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle1;
- (IBAction)actClick1:(id)sender;

@property (weak, nonatomic) IBOutlet MSImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *labTitle2;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle2;
- (IBAction)actClick2:(id)sender;

@end
