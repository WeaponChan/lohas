//
//  DyCommentCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DyCommentCell : UIView

-(void)updateInfo:(NSDictionary*)diction;

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labComment;


@end
