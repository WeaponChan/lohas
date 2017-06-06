//
//  EventViewInfCell.h
//  lohas
//
//  Created by juyuan on 15-5-9.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface EventViewInfCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

- (IBAction)actPhone:(id)sender;
- (IBAction)actLocation:(id)sender;
- (IBAction)actEvent:(id)sender;

@end
