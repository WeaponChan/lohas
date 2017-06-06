//
//  DynamicUserInfoViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface DynamicUserInfoViewController : MainViewController

@property(copy,nonatomic)NSString *user_id;

@property BOOL isFocus;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
- (IBAction)actAttention:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labNum1;
@property (weak, nonatomic) IBOutlet UILabel *labNum2;
@property (weak, nonatomic) IBOutlet UILabel *labNum3;
@property (weak, nonatomic) IBOutlet UILabel *labNum4;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)actFans:(id)sender;

- (IBAction)actAtten:(id)sender;
- (IBAction)actTrip:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageSex;

-(void)getMore;
- (IBAction)actHead:(id)sender;

@end
