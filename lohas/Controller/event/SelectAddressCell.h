//
//  SelectAddressCell.h
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "BMapKit.h"

@interface SelectAddressCell : MSTableViewCell

@property(weak,nonatomic)BMKPoiInfo *poiList;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;

- (IBAction)actClick:(id)sender;

@end
