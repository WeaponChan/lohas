//
//  Api.m
//  lxpai
//
//  Created by mudboy on 12-10-9.
//
//

#import "Api.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "MSStringUtil.h"
#import "SBJson.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIImagefixOrientation.h"

@implementation Api
@synthesize extra;

-(id)init:(id)delegate
{
    return [self init:delegate tag:nil cache:0];
}
-(id)init:(id)delegate cache:(int)cache
{
    return [self init:delegate tag:nil cache:0];
}
-(id)init:(id)delegate tag:(id)tag
{
    return [self init:delegate tag:tag cache:0];
}
-(id)init:(id)delegate tag:(id)tag cache:(int)cache
{
    self._delegate = delegate;
    self._tag = tag;
    self._cache = cache;
    needtoken = 0;
    return self;
}

-(NSMutableDictionary*) getToken
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    
    if(!token || token.length==0) {
        [self showError:@"请先登录"];
        return nil;
    }
    [params setValue:token forKey:@"token"];
    return params;
}

-(NSMutableDictionary*) addToken
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if(!token || token.length==0) {
    } else {
        [params setObject:token forKey:@"token"];
    }
    return params;
}

-(Boolean) isReachability
{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            return YES;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            return YES;
            break;
        default:
            break;
    }
    [self showError:@"请检查网络连接"];
    return NO;
}

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

-(NSString*) urlEncodedString:(NSDictionary*)params {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in params) {
        id value = [params objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

-(void) showLoaded:(id)JSON
{
    if(!self._delegate) return;
    
    if ([self._delegate respondsToSelector:@selector(loaded:tag:)])
    {
        [self._delegate performSelector:@selector(loaded:tag:) withObject:JSON withObject:self._tag];
        return;
    }
    
    if ([self._delegate respondsToSelector:@selector(loaded:)])
    {
        [self._delegate performSelector:@selector(loaded:) withObject:JSON];
    }
}

-(void) showError:(NSString*)error
{
    NSLog(@"showError:%@", error);
    
    if(!self._delegate) return;
    
    if ([self._delegate respondsToSelector:@selector(error:tag:)])
    {
        [self._delegate performSelector:@selector(error:tag:) withObject:error withObject:self._tag];
        return;
    }
    
    if ([self._delegate respondsToSelector:@selector(error:)])
    {
        [self._delegate performSelector:@selector(error:) withObject:error];
    }
}

-(void) showError:(NSString*)error code:(NSNumber*)code
{
    NSLog(@"showError:%@ code:%@", error, code);
    
    if(!self._delegate) return;
    
    if ([self._delegate respondsToSelector:@selector(errorcode:tag:)])
    {
        [self._delegate performSelector:@selector(errorcode:tag:) withObject:code withObject:self._tag];
        return;
    }
    if ([self._delegate respondsToSelector:@selector(error:tag:)])
    {
        [self._delegate performSelector:@selector(error:tag:) withObject:error withObject:self._tag];
        return;
    }
    if ([self._delegate respondsToSelector:@selector(error:)])
    {
        [self._delegate performSelector:@selector(error:) withObject:error];
    }
}

-(void) startRequest:(NSString*)api
{
    [self startRequest:api params:nil imageData:nil field:nil isPost:NO];
}

-(void) startRequest:(NSString*)api params:(NSMutableDictionary *)params
{
    [self startRequest:api params:params imageData:nil field:nil isPost:NO];
}

-(void) startPostRequest:(NSString*)api params:(NSMutableDictionary *)params
{
    [self startRequest:api params:params imageData:nil field:nil isPost:YES];
}

-(void) startRequest:(NSString*)api params:(NSMutableDictionary *)params imageData:(NSData*)imageData field:(NSString*)field isPost:(BOOL)isPost
{
    
    AFHTTPClient * Client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:host]];
    
    if (urlStr==1) {
        Client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:hostWap]];
    }
    
    if(params==nil) {
        params = [[NSMutableDictionary alloc] init];
    }
    
//    [params setObject:APIVERSION forKey:@"api"];
//    [params setObject:DEVICE forKey:@"device"];
//    [params setObject:APPVERSION forKey:@"ver"];
    NSLog(@"needtoken:%d",needtoken);
    if(needtoken>0) {
        NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
        if(!token || token.length==0 ) {
            if (needtoken==1) {
                [self showError:@"请先登录"];
                return;
            }
        }
        else{
            [params setObject:token forKey:@"token"];
         }
    }
    
    NSLog(@"api:%@ params:%@", api, params);
    
    NSString *str=[NSString stringWithFormat:@"%@%@?%@", Client.baseURL ,api, [self urlEncodedString:params]];
    NSLog(@"urlstr====%@",str);
    
    if(imageData && field) {
        
        NSURLRequest *request = [Client multipartFormRequestWithMethod:@"POST" path:api parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
            [formData appendPartWithFileData:imageData name:field fileName:@"image.jpg" mimeType:@"image/jpeg"];
        }];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            //NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response string: %@ ", operation.responseString);
            [self callback:operation.responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showError:@"服务器连接超时, 请检查网络"];
            NSLog(@"message: %@", operation.responseString);
        }];
        
        [operation start];
        
    } else if(isPost) {
        
        [Client postPath:api parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response string: %@ ", operation.responseString);
            [self callback:operation.responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showError:@"服务器连接超时, 请检查网络"];
            NSLog(@"message: %@", operation.responseString);
            
        }];
    } else {
        
        [Client getPath:api parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response string: %@ ", operation.responseString);
            [self callback:operation.responseString];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showError:@"服务器连接超时, 请检查网络"];
            NSLog(@"message: %@", operation.responseString);
            
        }];
    }
}


-(NSString*) fixjson:(NSString*)response
{
    if(!response) return nil;
    
    static NSCharacterSet *characterSet;
    
    if(!characterSet) {
        characterSet = [NSCharacterSet  characterSetWithCharactersInString:@"{["];
    }
    
    NSRange range = [response rangeOfCharacterFromSet:characterSet];
    
    if(range.location>0 && range.location != NSNotFound) {
        response = [response substringFromIndex:range.location];
    }
    
    return response;
}

-(NSString *)removeUnescapedCharacter:(NSString *)inputStr
{
    if(!inputStr) return inputStr;
    
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}

-(void) callback:(NSString*)response
{
    
    if(!self._delegate) return;
    
    //response=[self removeUnescapedCharacter:response];
    
    //response = [self fixjson:response];
    
    
    id JSON = [response JSONValue];
    
    if (!JSON || ![JSON isKindOfClass:[NSDictionary class]]) {
        [self showError:@"返回格式不正确"];
        return;
    }
    
    //NSLog(@"got %@", JSON);
    
    id success = [JSON objectForKey:@"success"];
    NSString* message = [JSON objectForKey:@"message"];
    NSNumber* code = [JSON objectForKey:@"error"];
    id data = [JSON objectForKey:@"data"];
    
    if ([message isEqual:@"请先登录"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    
    if(success && ![success boolValue]) {
        if([message isKindOfClass:[NSString class]] && message.length>0) {
        } else {
            message = @"";
        }
        if(code && [code isKindOfClass:[NSNumber class]]) {
            [self showError:message code:code];
        } else {
            [self showError:message];
        }
        return;
    }
    [self showLoaded:data];
}

-(void) ping
{
    
    if(![self isReachability]) {
        return;
    }
 
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"app" params:params];
}

-(void) get_current_city:(CLLocation *)location
{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    
    [self startRequest:@"api/app/get_current_city" params:params];
}

-(void) get_city_lists
{

    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_city_lists" params:params];
}

//用户登录
-(void)signin:(NSString*)tel password:(NSString*)password
{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:tel forKey:@"tel"];
    [params setObject:password forKey:@"password"];
    
    [self startRequest:@"api/auth/user_signin" params:params];
    
}
/*
//用户第三方登录
-(void)third_login:(NSString*)name type:(NSString*)type key:(NSString*)key
{
    if(![self isReachability]) {
        return;
    }
    needtoken = 0;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:name forKey:@"nick"];
    [params setObject:type forKey:@"type"];
    [params setObject:key forKey:@"key"];
    NSString* enKey = [NSString stringWithFormat:@"csSK8GHW34%@SY2tzEbRUm", key];
    NSString* sign = [enKey md5];
    [params setObject:sign forKey:@"sign"];
    [self startRequest:@"auth/third_login" params:params];
    
}
*/

//用户注册
-(void) signup:(NSString*)nick tel:(NSString*)tel password:(NSString*)password gender:(NSString*)gender code:(NSString*)code;
{
    if(![self isReachability])
    {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:tel forKey:@"tel"];
    [params setObject:password forKey:@"password"];
    [params setObject:nick forKey:@"nick"];
    [params setObject:gender forKey:@"sex"];
    [params setObject:code forKey:@"code"];
    
    [self startRequest:@"api/auth/user_signup" params:params];
    
}

//发送验证码
-(void)sendcode:(NSString*)tel type:(int)type
{
    
     //1=希望存在  2=希望不存在(数据库判断)
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:tel forKey:@"tel"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    
    [self startRequest:@"api/auth/send_code" params:params];
}



-(void)get_wrong_lists
{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_wrong_lists" params:params];
}

-(void) get_hotel_category_list
{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/hotel/get_category_lists" params:params];
}

-(void) get_hotel_list:(NSString*)title city_id:(NSString*)city_id category_id:(NSString*)category_id type:(int)type location:(CLLocation *)location page:(int)page count:(int)count date:(NSString*)date
{
    //type 1默认  2距离 3人气 4价格
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    if(title) {
        [params setObject:title forKey:@"title"];
    }
    if(city_id) {
        [params setObject:city_id forKey:@"city_id"];
    }
    if(category_id) {
        [params setObject:category_id forKey:@"category_id"];
    }
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    [params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
    [params setObject:date forKey:@"date"];
    
    [self startRequest:@"api/hotel/get_lists" params:params];
}

-(void) get_hotel_info:(NSString*)hotel_id date:(NSString*)date
{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:hotel_id forKey:@"id"];
    [params setObject:date forKey:@"date"];
    
    [self startRequest:@"api/hotel/get_hotel_info" params:params];
}


-(void)get_user_info
{
    
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/user/get_user_info" params:params];
}


-(void)update_info:(NSString*)nick sex:(int)sex sign:(NSString*)sign intro:(NSString*)intro
{
    
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(nick) {
        [params setObject:nick forKey:@"nick"];
    }
    if(sign) {
        [params setObject:sign forKey:@"sign"];
    }
    if(intro) {
        [params setObject:intro forKey:@"intro"];
    }
    [params setObject:[NSString stringWithFormat:@"%d", sex] forKey:@"sex"];
    
    [self startRequest:@"api/user/update_info" params:params];
}

-(void)update_pwd:(NSString*)oldpwd newpwd:(NSString*)newpwd repwd:(NSString*)repwd
{
    
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(oldpwd) {
        [params setObject:oldpwd forKey:@"oldpwd"];
    }
    if(newpwd) {
        [params setObject:newpwd forKey:@"newpwd"];
    }
    if(repwd) {
        [params setObject:repwd forKey:@"repwd"];
    }
    
    [self startRequest:@"api/user/update_pwd" params:params];
}


-(void)update_tel:(NSString*)tel code:(NSString*)code pwd:(NSString*)pwd
{
    
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(tel) {
        [params setObject:tel forKey:@"tel"];
    }
    if(code) {
        [params setObject:code forKey:@"code"];
    }
    [params setObject:pwd forKey:@"pwd"];
    
    [self startRequest:@"api/user/update_tel" params:params];
}

//修改头像
-(void)update_avatar:(UIImage *)avatar
{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(avatar) {
        avatar = [avatar fixOrientation];
        NSData* imageData = UIImageJPEGRepresentation(avatar, 0.7);
        [self startRequest:@"api/user/update_avatar" params:params imageData:imageData field:@"avatar" isPost:YES
         ];
    } else {
        return;
    }
    
}

-(void)submit_wrong:(NSString*)item_id type:(int)type category_id:(NSString*)category_id
{
    //type 1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    if(category_id) {
        [params setObject:category_id forKey:@"category_id"];
    }
    
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    
    [self startRequest:@"api/user/submit_wrong" params:params];
}

-(void)submit_comment:(NSNumber*)item_id type:(int)type score:(int)score content:(NSString*)content tag:(NSString*)tag
{
    //type 1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    if(content) {
        [params setObject:content forKey:@"content"];
    }
    [params setObject:[NSString stringWithFormat:@"%d", score] forKey:@"score"];
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    [params setObject:tag forKey:@"tag"];
    
    [self startRequest:@"api/user/submit_comment" params:params];
}


-(void)sibmit_photo:(NSNumber*)item_id type:(int)type photo:(UIImage *)photo
{
    //type 1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    
    if(![self isReachability]) {
        return;
    }
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    
    if(photo) {
        //avatar = [avatar fixOrientation];
        NSData* imageData = UIImageJPEGRepresentation(photo, 0.7);
        [self startRequest:@"api/user/sibmit_photo" params:params imageData:imageData field:@"avatar" isPost:YES
         ];
    } else {
        return;
    }
    
}


-(void)collect:(NSNumber*)item_id type:(int)type lat:(NSString*)lat lng:(NSString*)lng
{
    //type 1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    
    [self startRequest:@"api/user/collect" params:params];
}

-(void)del_collect:(NSNumber*)item_id type:(int)type
{
    //type 1=乡村游 2=景点 3=酒店 4=餐厅 5=购物
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    
    [params setObject:[NSString stringWithFormat:@"%d", type] forKey:@"type"];
    
    [self startRequest:@"api/user/del_collect" params:params];
}


-(void) my_collect_lists:(int)page count:(int)count location:(CLLocation *)location
{
    //type 1默认  2距离 3人气 4价格
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        double gg_lon=location.coordinate.longitude;
        double gg_lat=location.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        [params setObject:[NSString stringWithFormat:@"%f", bd_lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", bd_lon] forKey:@"lng"];
    }
    
    [params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    [params setObject:[NSString stringWithFormat:@"%d", count] forKey:@"count"];
    
    [self startRequest:@"api/user/my_collect_lists" params:params];
}


-(void)del_one_collect:(NSNumber*)item_id
{
 
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(item_id) {
        [params setObject:item_id forKey:@"id"];
    }
    
    [self startRequest:@"api/user/del_one_collect" params:params];
}

//获取当前城市
-(void)get_gsp_city:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    
    [self startRequest:@"api/app/get_gsp_city" params:params];
}

//获取飞机城市列表
-(void)get_flight_city_lists:(NSString*)type{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:type forKey:@"type"];
    
    [self startRequest:@"api/app/get_flight_city_lists" params:params];
}

//忘记密码
-(void)forget_password:(NSString*)tel password:(NSString*)password code:(NSString*)code{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:tel forKey:@"tel"];
    [params setObject:password forKey:@"password"];
    [params setObject:code forKey:@"code"];
    
    [self startRequest:@"api/auth/forget_password" params:params];
}

-(void)del_all_colelct
{
    
    if(![self isReachability]) {
        return;
    }
    
    needtoken = 1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/user/del_all_colelct" params:params];
}

//景点列表
-(void)get_View_lists:(NSString*)type city:(NSString*)city title:(NSString*)title page:(int)page count:(int)count location:(CLLocation *)location{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    
    [params setObject:type forKey:@"type"];
    [params setObject:city forKey:@"city"];
    [params setObject:title forKey:@"title"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    [self startRequest:@"api/poi/get_lists" params:params];
    
}

//乡村游列表
-(void)get_Country_lists:(NSString*)type city:(NSString*)city page:(int)page count:(int)count category_id:(NSString*)category_id title:(NSString*)title lat:(float)lat lng:(float)lng price_type:(NSString*)price_type{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(lat>0 && lat) {
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lng] forKey:@"lng"];
    }
    
    [params setObject:type forKey:@"type"];
    [params setObject:city forKey:@"city"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:category_id forKey:@"category"];
    [params setObject:title forKey:@"title"];
    [params setObject:price_type forKey:@"price_type"];
    
    [self startRequest:@"api/country/get_lists" params:params];
}

//餐厅
-(void)get_deal_lists:(NSString*)type city:(NSString*)city title:(NSString*)title page:(int)page count:(int)count price:(int)price location:(CLLocation *)location{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    
    [params setObject:type forKey:@"type"];
    [params setObject:city forKey:@"city"];
    [params setObject:title forKey:@"title"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:[NSNumber numberWithInt:price] forKey:@"price"];
    
    [self startRequest:@"api/deal/get_lists" params:params];
}

//查看帮助说明详情
-(void)get_help_info:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api/app/get_help_info" params:params];
}

//帮助列表
-(void)get_help_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_help_lists" params:params];
}

//活动
-(void)get_activity_lists:(int)page count:(int)count title:(NSString*)title city_id:(NSString*)city_id category:(NSString*)category lat:(float)lat lng:(float)lng type:(int)type price_type:(int)price_type{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(lat>0 && lat) {
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lng] forKey:@"lng"];
    }
    
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:category forKey:@"category"];
    [params setObject:title forKey:@"title"];
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:[NSNumber numberWithInt:price_type] forKey:@"price_type"];
    
    [self startRequest:@"api/activity/get_lists" params:params];
}

//购物
-(void)get_shopping_lists:(int)page count:(int)count category_id:(NSString*)category_id title:(NSString*)title city:(NSString*)city lat:(float)lat lng:(float)lng type:(NSString*)type price_type:(NSString*)price_type{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(lat>0 && lat) {
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lng] forKey:@"lng"];
    }
    
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:category_id forKey:@"category"];
    [params setObject:title forKey:@"title"];
    [params setObject:city forKey:@"city"];
    [params setObject:type forKey:@"type"];
    [params setObject:price_type forKey:@"price_type"];
    
    [self startRequest:@"api/shopping/get_lists" params:params];
}

//免责声明
-(void)get_user_intro{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_user_intro" params:params];
}

//乡村游分类
-(void)get_country_category_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/country/get_category_lists" params:params];
}

//购物分类
-(void)get_shopping_category_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/shopping/get_category_lists" params:params];
}

//Top列表
-(void)get_top_lists:(int)page count:(int)count city_id:(NSString*)city_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:city_id forKey:@"city_id"];
    
    [self startRequest:@"api/top/get_lists" params:params];
    
}

//获取Top详情
-(void)get_top_info:(NSString*)id location:(CLLocation*)location{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        
        double gg_lon=location.coordinate.longitude;
        double gg_lat=location.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        [params setObject:[NSString stringWithFormat:@"%f", bd_lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", bd_lon] forKey:@"lng"];
    }
    
    [params setObject:id forKey:@"id"];

    [self startRequest:@"api/top/get_top_info" params:params];
}

//检查新版本
-(void)check_version{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/check_version" params:params];
    
}

//乡村游详情接口
-(void)get_country_info:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    if(!id){
        id=@"";
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api/country/get_info" params:params];
}

//活动详情接口
-(void)get_activity_info:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api/activity/get_activity_info" params:params];
}

//购物详情
-(void)get_shopping_info:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api/shopping/get_shopping_info" params:params];
}

//团购筛选
-(void)get_category_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/shop/get_category_lists" params:params];
}

//团购搜索列表
-(void)shop:(int)page count:(int)count category:(NSString*)category title:(NSString*)title city_id:(NSString*)city_id location:(CLLocation *)location type:(NSString*)type price_type:(NSString*)price_type{
    if(![self isReachability]) {
        return;
    }
    
    if (!category) {
        category=@"";
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    double lat=location.coordinate.latitude;
    double lng=location.coordinate.longitude;
    if (lat==0) {
        [params setObject:@"" forKey:@"lat"];
        [params setObject:@"" forKey:@"lng"];
    }else{
        [params setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
        [params setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    }
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:category forKey:@"category"];
    [params setObject:title forKey:@"title"];
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:type forKey:@"type"];
    [params setObject:price_type forKey:@"price_type"];
    
    [self startRequest:@"api/shop/get_lists" params:params];
}

//团购，餐厅
-(void)find_businesses:(NSString*)category keyword:(NSString*)keyword sort:(NSString*)sort city:(NSString*)city limit:(int)limit page:(int)page location:(CLLocation *)location{
    
    if(![self isReachability]) {
        return;
    }
    
    if (!category) {
        category=@"";
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    double lat=location.coordinate.latitude;
    double lng=location.coordinate.longitude;
    if (lat==0) {
        [params setObject:@"" forKey:@"latitude"];
        [params setObject:@"" forKey:@"longitude"];
    }else{
        [params setObject:[NSNumber numberWithDouble:lat] forKey:@"latitude"];
        [params setObject:[NSNumber numberWithDouble:lng] forKey:@"longitude"];
    }
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    if (category.length>0) {
        [params setObject:category forKey:@"category"];
    }
    if (keyword.length>0) {
        [params setObject:keyword forKey:@"keyword"];
    }
    
    [params setObject:city forKey:@"city"];
    [params setObject:sort forKey:@"sort"];
    
    [self startRequest:@"api/shop/find_businesses" params:params];
}


//评论列表
-(void)comment_list:(NSString*)id type:(int)type page:(int)page count:(int)count{
    if(![self isReachability]) {
        return;
    }

    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    [self startRequest:@"api/common/comment_list" params:params];
}

//评价数量展示
-(void)comment_num:(NSString*)id type:(int)type{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    
    [self startRequest:@"api/common/comment_num" params:params];
}

//用户提交图片
-(void)sibmit_photo:(NSString*)id type:(int)type avatar:(UIImage*)avatar{
    if(![self isReachability]) {
        return;
    }
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    
    if(avatar) {
        avatar = [avatar fixOrientation];
        NSData* imageData = UIImageJPEGRepresentation(avatar, 0.7);
        
        
        [self startRequest:@"api/common/submit_photo" params:params imageData:imageData field:@"avatar" isPost:YES
         ];
    } else {
        return;
    }
}

//活动分类
-(void)get_activity_category_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/activity/get_category_lists" params:params];
}

//相册列表
-(void)photo_list:(NSString*)id type:(int)type page:(int)page count:(int)count{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    [self startRequest:@"api/common/photo_list" params:params];
}

//景点列表
-(void)get_travel_lists:(int)page count:(int)count title:(NSString*)title city_id:(NSString*)city_id lat:(float)lat lng:(float)lng type:(NSString*)type price_type:(NSString*)price_type category:(NSString*)category{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(lat>0 && lat) {
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lng] forKey:@"lng"];
    }
    
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:price_type forKey:@"price_type"];
    [params setObject:type forKey:@"type"];
    [params setObject:title forKey:@"title"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    [params setObject:category forKey:@"category"];
    
    [self startRequest:@"api/travel/get_lists" params:params];
    
}

//首页搜索
-(void)appSearch:(NSString*)keyword location:(CLLocation *)location type:(NSString*)type city_id:(NSString*)city_id city:(NSString*)city{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    
    if(type.length==0){
        type=@"1,6,5,2,4";
    }
    
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:keyword forKey:@"keyword"];
    [params setObject:type forKey:@"type"];
    [params setObject:city forKey:@"city"];
    
     [self startRequest:@"api/app/search" params:params];
}

//获取热门城市
-(void)get_hot_city{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_hot_city" params:params];
}

//活动收藏
-(void)activity_collect:(int)type activity_id:(NSString*)activity_id lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:activity_id forKey:@"activity_id"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    
    [self startRequest:@"api/activity/activity_collect" params:params];
}

//首页滚动
-(void)ad_list:(NSString*)city_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:city_id forKey:@"city_id"];
    
    [self startRequest:@"api/app/ad_list" params:params];
    
}

//酒店列表
-(void)get_hotel_list:(NSString*)title category_id:(NSString*)category_id type:(int)type price_type:(NSString*)price_type location:(CLLocation *)location city_id:(NSString*)city_id min:(NSString*)min max:(NSString*)max page:(int)page count:(int)count{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(location) {
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lng"];
    }
    
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:title forKey:@"title"];
    [params setObject:category_id forKey:@"category_id"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:price_type forKey:@"price_type"];
    [params setObject:min forKey:@"min"];
    [params setObject:max forKey:@"max"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    [self startRequest:@"api/hotel/hotel_list" params:params];

}

//酒店详情
-(void)get_hotel_info:(NSString*)hotel_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:hotel_id forKey:@"id"];
    
    [self startRequest:@"api/hotel/hotel_info" params:params];
}

-(void)room_list:(NSString*)hotel_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];

     [params setObject:hotel_id forKey:@"hotel_id"];
    
     [self startRequest:@"api/hotel/room_list" params:params];
}

//获取旅游标签
-(void)get_travel_category_lists{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/travel/get_category_lists" params:params];
}

//景点详情
-(void)getTravelInfo:(NSString*)travelID{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:travelID forKey:@"id"];
    
    [self startRequest:@"api/travel/get_info" params:params];
}

//餐厅列表
-(void)get_Dinner_lists:(NSString*)title category:(NSString*)category type:(int)type price_type:(NSString*)price_type  lat:(float)lat lng:(float)lng city_id:(NSString*)city_id page:(int)page count:(int)count{
    
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    if(lat>0 && lat) {
        [params setObject:[NSString stringWithFormat:@"%f", lat] forKey:@"lat"];
        [params setObject:[NSString stringWithFormat:@"%f", lng] forKey:@"lng"];
    }
    
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:title forKey:@"title"];
    [params setObject:category forKey:@"category"];
    [params setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    [params setObject:price_type forKey:@"price_type"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:count] forKey:@"count"];
    
    [self startRequest:@"api/shop/get_lists" params:params];
}

//餐厅详情
-(void)get_dinner_info:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api/shop/get_info" params:params];
}

//关于我们
-(void)get_about_intro{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api/app/get_about_intro" params:params];
    
}

//分享1=乡村游 2=景点 3=酒店 4=餐厅 5=购物 6=活动 
-(void)apiInfo:(NSString*)type{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:type forKey:@"type"];
    
    [self startRequest:@"api/common/share" params:params];
}



#pragma mark 二期
//公共部分
//1app首页
-(void)index:(NSString*)cityId lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:cityId forKey:@"cityId"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    
    [self startRequest:@"api2/index/index" params:params];
}
//2上传图片
-(void)upload:(UIImage*)userfile{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    if(userfile) {
        userfile = [userfile fixOrientation];
        NSData* imageData = UIImageJPEGRepresentation(userfile, 0.7);
        [self startRequest:@"api2/index/upload" params:params imageData:imageData field:@"userfile" isPost:YES
         ];
    } else {
        return;
    }
    
}
//3获取举报须知
-(void)getReportNotice{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/getReportNotice" params:params];
}

//4获取举报类别列表
-(void)getReportCategory{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/getReportCategory" params:params];
}

//5举报操作
-(void)submitReport:(NSString*)type data:(NSString*)data category_id:(NSString*)category_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:type forKey:@"type"];
    [params setObject:data forKey:@"data"];
    [params setObject:category_id forKey:@"category_id"];
    
    [self startRequest:@"api2/index/submitReport" params:params];
}

//6常见问题列表
-(void)problemList{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/problemList" params:params];
}

//7常见问题详情
-(void)problemDetail:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api2/index/problemDetail" params:params];
}

//8关注列表
-(void)collectList:(int)page limit:(int)limit lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/user/collectList" params:params];
}
//9添加行程
-(void)addJourney:(NSString*)title content:(NSString*)content{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    
    [self startRequest:@"api2/user/addJourney" params:params];
}

-(void)editJourney:(NSString*)id title:(NSString*)title content:(NSString*)content{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    [params setObject:title forKey:@"title"];
    [params setObject:content forKey:@"content"];
    
    [self startRequest:@"api2/user/editJourney" params:params];
}

//10我的行程
-(void)journeyList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/user/journeyList" params:params];
}
//11查看我的行程
-(void)journeyDetail:(NSString*)id lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api2/user/journeyDetail" params:params];
}
//12删除行程
-(void)journeyDel:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];

    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api2/user/journeyDel" params:params];
}

//13设置是否公开行程
-(void)isOpen:(NSString*)isOpen{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:isOpen forKey:@"is_open"];
    
    [self startRequest:@"api2/user/isOpen" params:params];
}

//14分享接口
-(void)share{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/share" params:params];
}

//15分享链接
-(void)shareUrl{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/shareUrl" params:params];
}

//16国内城市列表
-(void)getCity{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/getCity" params:params];
}

//17搜索城市
-(void)searchCity:(NSString*)keyword{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:keyword forKey:@"keyword"];
    
    [self startRequest:@"api2/index/searchCity" params:params];
    
}

//19热门词列表
-(void)hotKeywordList{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/hotKeywordList" params:params];
}

//20国内城市定位
-(void)getGpsCity:(double)lat lng:(double)lng{
    
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [params setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    
    [self startRequest:@"api2/index/getGpsCity" params:params];
    
}

//21国际城市定位
-(void)getInternationGpsCity:(double)lat lng:(double)lng{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [params setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    
    [self startRequest:@"api2/index/getInternationGpsCity" params:params];
}

//22国际城市列表
-(void)getInternationCityList{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/index/getInternationCityList" params:params];
}


//21指南分享
-(void)guideShare:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"wap/share/guideShare" params:params];
}
-(void)weather:(NSString *)city{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject: city forKey:@"city"];
    
    [self startRequest:@"api2/index/weather" params:params];
    
}




//动态部分
//1发布动态
-(void)submitSaid:(NSString*)content picture:(NSString*)picture address:(NSString*)address{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:content forKey:@"content"];
    [params setObject:picture forKey:@"picture"];
    [params setObject:address forKey:@"address"];
    
    [self startRequest:@"api2/said/submitSaid" params:params];
}
//2动态列表
-(void)saidList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/saidList" params:params];
}

//3关注或取消关注对方
-(void)attentionAction:(NSString*)user_id type:(NSString*)type{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:type forKey:@"type"];
    
    [self startRequest:@"api2/said/attentionAction" params:params];
}

//4关注的动态
-(void)saidListByAttention:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/saidListByAttention" params:params];
}

//5点赞或者取消点赞
-(void)goodAction:(NSString*)said_id type:(NSString*)type{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    [params setObject:type forKey:@"type"];
    
    [self startRequest:@"api2/said/goodAction" params:params];
}

//6评论动态
-(void)saidComment:(NSString*)content said_id:(NSString*)said_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    [params setObject:content forKey:@"content"];
    
    [self startRequest:@"api2/said/saidComment" params:params];
}
//7点赞用户列表
-(void)goodUserList:(int)page limit:(int)limit said_id:(NSString*)said_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/goodUserList" params:params];
}

//8评论列表
-(void)saidCommentList:(int)page limit:(int)limit said_id:(NSString*)said_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/saidCommentList" params:params];
}

//9查看对方主页
-(void)homePage:(NSString*)user_id page:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/homePage" params:params];
}

//10查看对方的粉丝
-(void)fansList:(int)page limit:(int)limit user_id:(NSString*)user_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/fansList" params:params];
}

//11查看对方关注的列表
-(void)attentionList:(int)page limit:(int)limit user_id:(NSString*)user_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/attentionList" params:params];
}

//12动态详情
-(void)saidDetail:(NSString*)said_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    
    [self startRequest:@"api2/said/saidDetail" params:params];
}

//13拉黑名单
-(void)submitBlack:(NSString*)user_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    
    [self startRequest:@"api2/said/submitBlack" params:params];
}
//14黑名单列表
-(void)blackList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/blackList" params:params];
}
//15移除黑名单
-(void)removeBlack:(NSString*)user_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:user_id forKey:@"user_id"];
    
    [self startRequest:@"api2/said/removeBlack" params:params];
}
//16我的动态列表
-(void)mySaidList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/mySaidList" params:params];
}
//17我的粉丝
-(void)myFansList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/myFansList" params:params];
}

//18我的关注
-(void)myAttentionList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/myAttentionList" params:params];
}

//19消息列表
-(void)messageList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/messageList" params:params];
}

//20查看对方行程
-(void)OjourneyList:(NSString*)user_id page:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    [params setObject:user_id forKey:@"user_id"];
    
    [self startRequest:@"api2/said/journeyList" params:params];
}

//21删除动态
-(void)delMySaid:(NSString*)said_id{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:said_id forKey:@"said_id"];
    
    [self startRequest:@"api2/said/delMySaid" params:params];
}

//22查看对方行程详情
-(void)OjourneyDetail:(NSString*)id lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    
    [self startRequest:@"api2/said/journeyDetail" params:params];
}

//23动态搜索列表
-(void)searchSaidList:(NSString*)keyword page:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:keyword forKey:@"keyword"];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/said/searchSaidList" params:params];
}

//24判断是否有新消息
-(void)isNewMessage{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=1;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/said/isNewMessage" params:params];
}

//发现部分
//1指南列表
-(void)guideList:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    needtoken=2;
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [self startRequest:@"api2/guide/guideList" params:params];
}
//2指南详情
-(void)guideDetail:(NSString*)id lat:(double)lat lng:(double)lng{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    [params setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [params setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    
    [self startRequest:@"api2/guide/guideDetail" params:params];
    
    
}
//3搜索指南
-(void)guideSearch:(NSString*)keyword page:(int)page limit:(int)limit{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSNumber numberWithInt:page] forKey:@"page"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    [params setObject:keyword forKey:@"keyword"];
    
    [self startRequest:@"api2/guide/guideSearch" params:params];
}

//4排行列表
-(void)rankList{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
    [self startRequest:@"api2/guide/rankList" params:params];
}

//5地区列表
-(void)areaList:(NSString*)category_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:category_id forKey:@"category_id"];
    
    [self startRequest:@"api2/guide/areaList" params:params];
}

//6查看排行列表
-(void)topList:(NSString*)area_id category_id:(NSString*)category_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:category_id forKey:@"category_id"];
    [params setObject:area_id forKey:@"area_id"];
    
    [self startRequest:@"api2/guide/topList" params:params];
}

//7查看感兴趣的商家列表
-(void)interestShopList:(NSString*)id category_id:(NSString*)category_id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:category_id forKey:@"category_id"];
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api2/guide/interestShopList" params:params];
}

//8查看top10下商家列表
-(void)shopListByTop:(NSString*)top_id lat:(NSString*)lat lng:(NSString*)lng{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:top_id forKey:@"top_id"];
    [params setObject:lat forKey:@"lat"];
    [params setObject:lng forKey:@"lng"];
    
    [self startRequest:@"api2/guide/shopListByTop" params:params];
}

//目的地
-(void)destinationInfo:(NSString*)id{
    if(![self isReachability]) {
        return;
    }
    
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:id forKey:@"id"];
    
    [self startRequest:@"api2/destination/getInfo" params:params];
}


-(void) test
{
    [self callback:@"{\"success\":1,\"data\":[{\"title\":\"标题1\"},{\"title\":\"标题2\"},{\"title\":\"标题3\"},{\"title\":\"标题4\"},{\"title\":\"标题5\"},{\"title\":\"标题6\"},{\"title\":\"标题7\"},{\"title\":\"标题8\"},{\"title\":\"标题9\"},{\"title\":\"标题10\"}]}"];
}

-(void) test:(NSString*)d
{
    [self callback:d];
}

-(void) version:(NSString*)appleID
{
    
    AFHTTPClient * Client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://itunes.apple.com"]];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:appleID forKey:@"id"];
    
    NSLog(@"params:%@", params);
    
    [Client getPath:@"/lookup" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[self callback:operation.responseString];
        
        id data = [operation.responseString JSONValue];
        [self showLoaded:data];
        
        NSLog(@"version: %@", operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showError:@"服务器连接超时, 请检查网络"];
        NSLog(@"message: %@", operation.responseString);
        
    }];
    
}




@end
