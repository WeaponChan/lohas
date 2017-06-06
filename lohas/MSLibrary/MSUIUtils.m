//
//  MSUIUtils.m
//
//  Created by 沈维秋 on 11-7-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MSUIUtils.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@implementation MSUIUtils

//根据Cell的Nib名称创建Cell
+(UITableViewCell *) newCellByNibName:(UITableView *)tableView NibName:(NSString *) nibName
{
    UITableViewCell *cell = [self newCellByNibName:tableView NibName:nibName Style: UITableViewCellSelectionStyleNone];
    return cell;
}

+(UITableViewCell *) newCellByNibName:(UITableView *)tableView NibName:(NSString *) nibName Style:(UITableViewCellSelectionStyle) CellStyle
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@",nibName];
    
    UITableViewCell *cell= (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        //NSLog([NSString stringWithFormat:@"----------------newCellByNibName to new: %@",nibName]);
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options: nil];
        cell = [nib objectAtIndex: 0];
        [cell setSelectionStyle:CellStyle];
        //[cell autorelease];
        cell.tag = 1;
    }else{
        cell.tag = 0;
    }
    return cell;
}

+(void)recoverSetting
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"auto_download_picture"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"auto_full_screen"];
    [[NSUserDefaults standardUserDefaults] setValue:@"mid" forKey:@"font_size"];
    [[NSUserDefaults standardUserDefaults] setValue:@"20" forKey:@"histroy_number"];
}

+(NSString *)replaceFace:(NSString *)context
{
    NSString *faceStr1;
    for (int i=1; i<=40; i++) {
        faceStr1=[NSString stringWithFormat:@"[newem23.%d]",i];
        if ([context rangeOfString:faceStr1].length>0) {
            context=[context stringByReplacingOccurrencesOfString:faceStr1 withString:[NSString stringWithFormat:@"<img src=\"bundle://newem23.%d.gif\"/>",i]];
        }
    }
    NSString *faceStr2;
    for (int i=1; i<89; i++) {
        faceStr2=[NSString stringWithFormat:@"[newem2.%d]",i];
        if ([context rangeOfString:faceStr2].length>0) {
            context=[context stringByReplacingOccurrencesOfString:faceStr2 withString:[NSString stringWithFormat:@"<img src=\"bundle://newem2.%d.gif\"/>",i]];
        }
    }
    return context;
}


+(int)getFontSize
{
    NSString *localSize = [[NSUserDefaults standardUserDefaults] objectForKey:@"font_size"];
    //NSLog(@"%@---localSize",localSize);
    int fontSize=0;
    if ([localSize isEqualToString:@"big"]) {
        fontSize=18;
    }else if([localSize isEqualToString:@"mid"]){
        fontSize=16;
    }else if([localSize isEqualToString:@"sml"]){
        fontSize=14;
    }
    return fontSize;
}

+(void)setImage:(MSImageView *)imageView URL:(NSString*)url
{
    [MSUIUtils setImage:imageView URL:url placeholderImage:[UIImage imageNamed:@"img_default.png"]];

}

+(void)setImage:(MSImageView *)imageView URL:(NSString*)url placeholderImage:(UIImage *)img
{
    if(url==nil) {
        return;
    }
    //imageView.showsLoadingActivity = YES;
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(@"retrieve img:%@", url);
    
    [imageView loadImageAtURLString:url placeholderImage:img];
    
    
    //[imageView setImageWithURL:[NSURL URLWithString:url]];
    
}

+(CLLocationDistance)getDistance:(CLLocation*)location lat:(NSString*)lat lng:(NSString*)lng
{

CLLocation* dist= [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lng doubleValue] ];

CLLocationDistance meters = [dist distanceFromLocation:location];
    NSLog(@"距离: %f",meters);
    
    return meters;
}


//获取系统版本号
+(float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}








/**
 调用Map客户端
 @param desCoordinate:目的地的经纬度（注意：纬度在前，经度在后）
 @param desName:目的地标识显示的文字信息，默认值为“目的地”
 */
+ (void)callMapView:(CLLocationCoordinate2D)desCoordinate andDesName:(NSString *)desName
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0f) {
        //ios_version为4.0～5.1时 调用谷歌地图客户端
        
        //生成url字符串
        NSString *desLocation = [NSString stringWithFormat:@"%f,%f",
                                 desCoordinate.latitude,
                                 desCoordinate.longitude];
        NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%@",
                               desLocation];
        //转换为utf8编码
        urlString =  [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        UIApplication *app =[UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:urlString];
        
        //验证url是否可用
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }else{
        }
        
    }else{
        //ios_version为 >=6.0时 调用苹果地图客户端
        
        //验证MKMapItem的有效性
        Class itemClass = [MKMapItem class];
        if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
            desName = desName?desName:@"目的地";
            NSDictionary *dicOfAddress = [NSDictionary dictionaryWithObjectsAndKeys:
                                          desName,(NSString *)kABPersonAddressStreetKey, nil];
            MKPlacemark *palcemake = [[MKPlacemark alloc] initWithCoordinate:desCoordinate addressDictionary:dicOfAddress];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:palcemake];
            
            /*
            NSDictionary *dicOfMode = [NSDictionary dictionaryWithObjectsAndKeys:
                                       MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsDirectionsModeKey, nil];
             */
            //打开客户端
            if (![mapItem openInMapsWithLaunchOptions:nil]) {
            }
        }
        
    }
    
}

















@end
