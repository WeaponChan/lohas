//
//  MyFocusTripViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "AddTripList.h"

@protocol selectTripDelegate <NSObject>

-(void)endSelect:(NSMutableArray*)selectTripList;

@end

@interface MyFocusTripViewController : MainViewController{
    NSMutableArray *selectList;
}

@property(retain,nonatomic)id<selectTripDelegate> delegate;

@property (weak, nonatomic) IBOutlet AddTripList *mAddTripList;

@end
