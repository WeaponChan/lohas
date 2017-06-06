//
//  DynamicCollectionViewCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface DynamicCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;

-(void)updateCell:(MSViewController*)parentCtrl itemData:(NSDictionary*)itemData;

- (IBAction)actClick:(id)sender;

@end
