//
//  DiscoverRankCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DiscoverRankCell : MSTableViewCell

@property(copy,nonatomic)NSString *category_id;

@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;

- (IBAction)actClick:(id)sender;


@end
