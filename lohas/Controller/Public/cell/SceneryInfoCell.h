//
//  SceneryInfoCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface SceneryInfoCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

- (IBAction)actPhone:(id)sender;
- (IBAction)actLocation:(id)sender;
- (IBAction)actWeb:(id)sender;


@end
