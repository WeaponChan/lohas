//
//  DiscoverMainCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DiscoverMainCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;

@property (weak, nonatomic) IBOutlet UILabel *labSub;
@property (weak, nonatomic) IBOutlet UILabel *labMain;

- (IBAction)actClick:(id)sender;
- (IBAction)actClickSub:(id)sender;
- (IBAction)actClickMain:(id)sender;


@end
