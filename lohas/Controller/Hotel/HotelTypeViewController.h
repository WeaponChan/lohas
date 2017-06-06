//
//  HotelTypeViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "HotelTypeList.h"
#import "MSButtonToAction.h"

@protocol typeSelectedDelegate <NSObject>

-(void)selectedType:(NSString*)type name:(NSString*)name;

@end

@interface HotelTypeViewController : MainViewController

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;
@property (weak, nonatomic) IBOutlet HotelTypeList *mHotelTypeList;

-(void)changeStyle:(NSString*)index;
@property (weak, nonatomic) IBOutlet UIImageView *labTag;

@property(weak,nonatomic)id<typeSelectedDelegate>delegate;

@end
