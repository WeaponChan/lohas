//
//  PlaceViewCell.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface PlaceViewCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

- (IBAction)actCommentMore:(id)sender;
- (IBAction)actFood:(id)sender;
- (IBAction)actHotel:(id)sender;
- (IBAction)actScenery:(id)sender;
- (IBAction)actCountry:(id)sender;
- (IBAction)actShopping:(id)sender;
- (IBAction)actEvent:(id)sender;
- (IBAction)actTuangou:(id)sender;
- (IBAction)actBuymenpiao:(id)sender;

@property int type;
@property (copy,nonatomic)NSString *selID;
@property(copy,nonatomic)NSDictionary *infoItem;

@end
