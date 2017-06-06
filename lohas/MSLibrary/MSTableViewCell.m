//
//  MSTableViewCell.m
//  xyhui
//
//  Created by shen xmload on 13-5-21.
//
//

#import "MSTableViewCell.h"

@implementation MSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    item = itemData;
    parent = parentCtrl;
    
    //NSLog(@"itemData:%@", item);
    
}
+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

@end
