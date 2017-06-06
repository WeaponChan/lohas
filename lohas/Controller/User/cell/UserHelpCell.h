//
//  UserHelpCell.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface UserHelpCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

- (IBAction)actHelp:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@end
