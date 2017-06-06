//
//  PublishImageViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/4/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@protocol deleteImageDelegate <NSObject>

-(void)deleteSuccess;

@end

@interface PublishImageViewController : MainViewController

@property(weak,nonatomic)id <deleteImageDelegate>delegate;

@property (weak, nonatomic) IBOutlet MSImageView *imageView;
@property(copy,nonatomic)NSString *imagestr;

@end
