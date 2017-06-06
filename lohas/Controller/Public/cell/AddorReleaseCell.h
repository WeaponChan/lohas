//
//  AddorReleaseCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/14.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface AddorReleaseCell : UICollectionViewCell

-(void)updateCell:(MSViewController*)parentCtrl item:(NSDictionary*)item;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
- (IBAction)actAdd:(id)sender;

@end
