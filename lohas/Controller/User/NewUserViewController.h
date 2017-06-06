//
//  NewUserViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface NewUserViewController : MainViewController

@property BOOL isOtherIn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;

@property (weak, nonatomic) IBOutlet UILabel *labNum1;
@property (weak, nonatomic) IBOutlet UILabel *labNum2;
@property (weak, nonatomic) IBOutlet UILabel *labNum3;
@property (weak, nonatomic) IBOutlet UILabel *labNum4;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)actEditInfo:(id)sender;
- (IBAction)actFans:(id)sender;
- (IBAction)actAttention:(id)sender;

- (IBAction)actTrip:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIView *viewMid;
@property (weak, nonatomic) IBOutlet UIImageView *imageSex;


-(void)getMore;

@end
