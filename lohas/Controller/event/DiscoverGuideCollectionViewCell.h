//
//  DiscoverGuideCollectionViewCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/26.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface DiscoverGuideCollectionViewCell : UICollectionViewCell

-(void)updateCell:(MSViewController*)parentCtrl itemData:(NSDictionary*)itemData;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;

- (IBAction)actClick:(id)sender;


@end
