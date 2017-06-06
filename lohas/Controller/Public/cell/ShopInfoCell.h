//
//  ShopInfoCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface ShopInfoCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *resItem;
@property(copy,nonatomic)NSDictionary *infoItem;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

- (IBAction)actPhone:(id)sender;
- (IBAction)actMap:(id)sender;
- (IBAction)actShopWEB:(id)sender;


@end
