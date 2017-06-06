//
//  PhotoGetMoreCell.h
//  lohas
//
//  Created by fred on 15-4-23.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface PhotoGetMoreCell : UICollectionViewCell

-(void)updateCell:(MSViewController*)parentCtrl item:(NSDictionary*)item;

- (IBAction)actGetMore:(id)sender;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;


@end
