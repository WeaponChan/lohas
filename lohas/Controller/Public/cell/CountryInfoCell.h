//
//  CountryInfoCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface CountryInfoCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (weak, nonatomic) IBOutlet UILabel *labWebName;

- (IBAction)actPhone:(id)sender;
- (IBAction)actLocation:(id)sender;
- (IBAction)actWeb:(id)sender;

@property(copy,nonatomic)NSString* categoryStr;

@end
