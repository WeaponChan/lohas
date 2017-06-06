//
//  Validate.h
//  IOSKDD
//
//  Created by DY030 on 13-11-27.
//  Copyright (c) 2013年 江苏德赢软件科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject

+(BOOL)validateMobile:(NSString *)mobileNum;

+(BOOL)validateEmail:(NSString *)email;

+(BOOL)validatePassWord:(NSString  *)_text;

+(BOOL)isEmpty:(NSString  *)_text;

//判断用户名
+(BOOL)validateUserName:(NSString *)user;

@end
