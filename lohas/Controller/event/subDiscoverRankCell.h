//
//  subDiscoverRankCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface subDiscoverRankCell : MSTableViewCell

@property(copy,nonatomic)NSString *category_id;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

- (IBAction)actClick:(id)sender;

@end
