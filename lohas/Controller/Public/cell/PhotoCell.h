//
//  PhotoCell.h
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface PhotoCell : UICollectionViewCell

-(void)updateCell:(MSViewController*)parentCtrl itemData:(NSDictionary*)itemData;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
- (IBAction)actImage:(id)sender;

@property(copy,nonatomic)NSArray *photoList;

@end
