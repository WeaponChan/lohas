//
//  FlightsListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//


#import"MSTableViewCell.h"

@interface FlightsListCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

- (IBAction)actFlightOrder:(id)sender;

@end
