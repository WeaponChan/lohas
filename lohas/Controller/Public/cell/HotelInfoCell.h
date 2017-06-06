//
//  HotelInfoCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface HotelInfoCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *responseItem;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labTel;

- (IBAction)actMap:(id)sender;
- (IBAction)actPhone:(id)sender;
- (IBAction)actWeb:(id)sender;
- (IBAction)actRoomList:(id)sender;

@end
