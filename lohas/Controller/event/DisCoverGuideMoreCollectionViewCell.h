//
//  DisCoverGuideMoreCollectionViewCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface DisCoverGuideMoreCollectionViewCell : UICollectionViewCell

-(void)updateCell:(MSViewController*)parentCtrl item:(NSDictionary*)item;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
//获取更多
- (IBAction)actGetMore:(id)sender;

@end
