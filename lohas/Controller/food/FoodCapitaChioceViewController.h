//
//  FoodCapitaChioceViewController.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodGroupList.h"

@protocol CapitaChiocedelegate <NSObject>

-(void)getCapita:(int)type title:(NSString*)title;

@end

@interface FoodCapitaChioceViewController : MainViewController

@property(weak,nonatomic)id<CapitaChiocedelegate>delegate;

- (IBAction)actButton:(id)sender;


@end
