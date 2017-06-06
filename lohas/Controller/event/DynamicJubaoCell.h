//
//  DynamicJubaoCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DynamicJubaoCell : MSTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

- (IBAction)actSelect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSele;

@end
