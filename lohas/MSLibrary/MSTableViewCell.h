//
//  MSTableViewCell.h
//  xyhui
//
//  Created by shen xmload on 13-5-21.
//
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"
#import "MSViewFrameUtil.h"

@interface MSTableViewCell : UITableViewCell{
    MSViewController *parent;
    NSDictionary *item;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl;
+ (int)Height:(NSDictionary *)itemData;


@end
