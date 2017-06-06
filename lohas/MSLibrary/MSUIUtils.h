//
//  MSUIUtils.h
//
//  Created by 沈维秋 on 11-7-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSImageView.h"
#import <CoreLocation/CoreLocation.h>

#define kOAuthConsumerKey @"..."
#define kOAuthConsumerSecret @"..."

#define onePageLimit 2000

@interface MSUIUtils : NSObject {
    
}

+(UITableViewCell *) newCellByNibName:(UITableView *)tableView NibName:(NSString *) nibName;

+(UITableViewCell *) newCellByNibName:(UITableView *)tableView NibName:(NSString *) nibName Style:(UITableViewCellSelectionStyle)CellStyle;

+(UIColor *) getNaviTintColor;

+(void)recoverSetting;

+(NSString *)replaceFace:(NSString *)context;

+(int)getFontSize;

+(void)setImage:(MSImageView *)imageView URL:(NSString*)url;
+(void)setImage:(MSImageView *)imageView URL:(NSString*)url placeholderImage:(UIImage *)img;

+(CLLocationDistance)getDistance:(CLLocation*)location lat:(NSString*)lat lng:(NSString*)lng;

+(float)getIOSVersion;

+ (void)callMapView:(CLLocationCoordinate2D)desCoordinate andDesName:(NSString *)desName;
@end
