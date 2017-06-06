//
//  NewTabMainHeadCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "BannerView.h"

@interface NewTabMainHeadCell : MSTableViewCell{
    BannerView *bannerView;
}

@property (weak, nonatomic) IBOutlet UIView *viewBanner;
@property (weak, nonatomic) IBOutlet UILabel *labDu;
@property (weak, nonatomic) IBOutlet UILabel *labWeather;
@property (copy,nonatomic)NSString *city;
@end
