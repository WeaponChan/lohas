//
//  Api.h
//  lxpai
//
//  Created by mudboy on 12-10-9.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//测试
//static NSString* host = @"http://lohas.juyuanchuangshi.com/api/"; //一期
static NSString* host = @"http://lohas2.dev.lohas-travel.com/"; //二期

//正式
//static NSString* host = @"http://admin.lohas-travel.com/api";
//static NSString* host = @"http://api.lohas-travel.com/api/";//1.0.4


static NSString* hostWap = @"http://u.ctrip.com/union/";

@interface Api : NSObject {
    //0不要 1必需 2可选
    int needtoken;
    int urlStr;
}

@property (nonatomic, retain)id _delegate;
@property (nonatomic, retain)id extra;
@property (nonatomic, retain)id _tag;
@property (nonatomic, retain)NSString* _key;
@property (nonatomic, assign)int _cache;

-(id)init:(id)delegate;
-(id)init:(id)delegate cache:(int)cache;
-(id)init:(id)delegate tag:(id)tag;
-(id)init:(id)delegate tag:(id)tag cache:(int)cache;

-(void) callback:(NSString*)response;
-(void) signup:(NSString*)nick tel:(NSString*)tel password:(NSString*)password gender:(NSString*)gender code:(NSString*)code;

-(void) ping;

//发送验证码
-(void) sendcode:(NSString*)tel type:(int)type;
//登录
-(void) signin:(NSString*)tel password:(NSString*)password;
//获取城市列表
-(void) get_city_lists;
//获取当前城市
-(void) get_current_city:(CLLocation *)location;
//忘记密码
-(void)forget_password:(NSString*)tel password:(NSString*)password code:(NSString*)code;

-(void) get_wrong_lists;
-(void) get_hotel_category_list;
-(void) get_hotel_info:(NSString*)hotel_id date:(NSString*)date;
-(void) get_user_info;
-(void) update_info:(NSString*)nick sex:(int)sex sign:(NSString*)sign intro:(NSString*)intro;
-(void) update_pwd:(NSString*)oldpwd newpwd:(NSString*)newpwd repwd:(NSString*)repwd;
-(void) update_tel:(NSString*)tel code:(NSString*)code pwd:(NSString*)pwd;
-(void) update_avatar:(UIImage *)avatar;
-(void) submit_wrong:(NSString*)item_id type:(int)type category_id:(NSString*)category_id;

-(void) sibmit_photo:(NSNumber*)item_id type:(int)type photo:(UIImage *)photo;
-(void) collect:(NSNumber*)item_id type:(int)type lat:(NSString*)lat lng:(NSString*)lng;
-(void) del_collect:(NSNumber*)item_id type:(int)type;
-(void) my_collect_lists:(int)page count:(int)count location:(CLLocation *)location;
-(void) del_one_collect:(NSNumber*)item_id;
-(void) del_all_colelct;

//获取当前城市
-(void)get_gsp_city:(NSString*)lat lng:(NSString*)lng;
//获取飞机城市列表
-(void)get_flight_city_lists:(NSString*)type;
//景点列表
-(void)get_View_lists:(NSString*)type city:(NSString*)city title:(NSString*)title page:(int)page count:(int)count location:(CLLocation *)location;
//乡村游列表
-(void)get_Country_lists:(NSString*)type city:(NSString*)city page:(int)page count:(int)count category_id:(NSString*)category_id title:(NSString*)title lat:(float)lat lng:(float)lng price_type:(NSString*)price_type;
//团购(餐厅)
-(void)get_deal_lists:(NSString*)type city:(NSString*)city title:(NSString*)title page:(int)page count:(int)count price:(int)price location:(CLLocation *)location;
//查看帮助说明详情
-(void)get_help_info:(NSString*)id;
//帮助列表
-(void)get_help_lists;
//活动
-(void)get_activity_lists:(int)page count:(int)count title:(NSString*)title city_id:(NSString*)city_id category:(NSString*)category lat:(float)lat lng:(float)lng type:(int)type price_type:(int)price_type;
//购物
-(void)get_shopping_lists:(int)page count:(int)count category_id:(NSString*)category_id title:(NSString*)title city:(NSString*)city lat:(float)lat lng:(float)lng type:(NSString*)type price_type:(NSString*)price_type;
//免责声明
-(void)get_user_intro;
//乡村游分类
-(void)get_country_category_lists;
//购物分类
-(void)get_shopping_category_lists;
//Top列表
-(void)get_top_lists:(int)page count:(int)count city_id:(NSString*)city_id;
//获取Top详情
-(void)get_top_info:(NSString*)id location:(CLLocation*)location;
//检查新版本
-(void)check_version;
//乡村游详情接口
-(void)get_country_info:(NSString*)id;
//活动详情接口
-(void)get_activity_info:(NSString*)id;
//购物详情
-(void)get_shopping_info:(NSString*)id;
//团购筛选
-(void)get_category_lists;
//团购搜索列表
-(void)shop:(int)page count:(int)count category:(NSString*)category title:(NSString*)title city_id:(NSString*)city_id location:(CLLocation *)location type:(NSString*)type price_type:(NSString*)price_type;
//评论列表
-(void)comment_list:(NSString*)id type:(int)type page:(int)page count:(int)count;
//评价数量展示
-(void)comment_num:(NSString*)id type:(int)type;
//用户提交图片
-(void)sibmit_photo:(NSString*)id type:(int)type avatar:(UIImage*)avatar;
//用户提交评价
-(void) submit_comment:(NSNumber*)item_id type:(int)type score:(int)score content:(NSString*)content tag:(NSString*)tag;
//活动分类
-(void)get_activity_category_lists;
//相册列表
-(void)photo_list:(NSString*)id type:(int)type page:(int)page count:(int)count;
//景点列表
-(void)get_travel_lists:(int)page count:(int)count title:(NSString*)title city_id:(NSString*)city_id lat:(float)lat lng:(float)lng type:(NSString*)type price_type:(NSString*)price_type category:(NSString*)category;
//活动收藏
-(void)activity_collect:(int)type activity_id:(NSString*)activity_id lat:(NSString*)lat lng:(NSString*)lng;
//获取热门城市
-(void)get_hot_city;

//团购，餐厅
-(void)find_businesses:(NSString*)category keyword:(NSString*)keyword sort:(NSString*)sort city:(NSString*)city limit:(int)limit page:(int)page location:(CLLocation *)location;
//首页搜索
-(void)appSearch:(NSString*)keyword location:(CLLocation *)location type:(NSString*)type city_id:(NSString*)city_id city:(NSString*)city;
//首页滚动
-(void)ad_list:(NSString*)city_id;
//酒店列表
-(void)get_hotel_list:(NSString*)title category_id:(NSString*)category_id type:(int)type price_type:(NSString*)price_type location:(CLLocation *)location city_id:(NSString*)city_id min:(NSString*)min max:(NSString*)max page:(int)page count:(int)count;
//酒店详情
-(void)get_hotel_info:(NSString*)hotel_id;
//房型列表
-(void)room_list:(NSString*)hotel_id;
//获取旅游标签
-(void)get_travel_category_lists;
//景点详情
-(void)getTravelInfo:(NSString*)travelID;
//餐厅列表
-(void)get_Dinner_lists:(NSString*)title category:(NSString*)category type:(int)type price_type:(NSString*)price_type lat:(float)lat lng:(float)lng city_id:(NSString*)city_id page:(int)page count:(int)count;
//餐厅详情
-(void)get_dinner_info:(NSString*)id;
//关于我们
-(void)get_about_intro;
//分享
-(void)apiInfo:(NSString*)type;

#pragma mark 二期
//公共部分
//1app首页
-(void)index:(NSString*)cityId lat:(NSString*)lat lng:(NSString*)lng;
//2上传图片
-(void)upload:(UIImage*)userfile;
//3获取举报须知
-(void)getReportNotice;
//4获取举报类别列表
-(void)getReportCategory;
//5举报操作
-(void)submitReport:(NSString*)type data:(NSString*)data category_id:(NSString*)category_id;
//6常见问题列表
-(void)problemList;
//7常见问题详情
-(void)problemDetail:(NSString*)id;
//8关注列表
-(void)collectList:(int)page limit:(int)limit lat:(NSString*)lat lng:(NSString*)lng;
//9添加行程
-(void)addJourney:(NSString*)title content:(NSString*)content;
//修改行程
-(void)editJourney:(NSString*)id title:(NSString*)title content:(NSString*)content;
//10我的行程
-(void)journeyList:(int)page limit:(int)limit;
//11查看我的行程
-(void)journeyDetail:(NSString*)id lat:(NSString*)lat lng:(NSString*)lng;
//12删除行程
-(void)journeyDel:(NSString*)id;
//13设置是否公开行程
-(void)isOpen:(NSString*)isOpen;
//14分享接口
-(void)share;
//15分享链接
-(void)shareUrl;

//16国内城市列表
-(void)getCity;
//17搜索城市
-(void)searchCity:(NSString*)keyword;
//19热门词列表
-(void)hotKeywordList;
//20国内城市定位
-(void)getGpsCity:(double)lat lng:(double)lng;
//21国际城市定位
-(void)getInternationGpsCity:(double)lat lng:(double)lng;
//22国际城市列表
-(void)getInternationCityList;




//21指南分享
-(void)guideShare:(NSString*)id;
-(void)weather:(NSString *)city;



//动态部分
//1发布动态
-(void)submitSaid:(NSString*)content picture:(NSString*)picture address:(NSString*)address;
//2动态列表
-(void)saidList:(int)page limit:(int)limit;
//3关注或取消关注对方
-(void)attentionAction:(NSString*)user_id type:(NSString*)type;
//4关注的动态
-(void)saidListByAttention:(int)page limit:(int)limit;
//5点赞或者取消点赞
-(void)goodAction:(NSString*)said_id type:(NSString*)type;
//6评论动态
-(void)saidComment:(NSString*)content said_id:(NSString*)said_id;
//7点赞用户列表
-(void)goodUserList:(int)page limit:(int)limit said_id:(NSString*)said_id;
//8评论列表
-(void)saidCommentList:(int)page limit:(int)limit said_id:(NSString*)said_id;
//9查看对方主页
-(void)homePage:(NSString*)user_id page:(int)page limit:(int)limit;
//10查看对方的粉丝
-(void)fansList:(int)page limit:(int)limit user_id:(NSString*)user_id;
//11查看对方关注的列表
-(void)attentionList:(int)page limit:(int)limit user_id:(NSString*)user_id;
//12动态详情
-(void)saidDetail:(NSString*)said_id;
//13拉黑名单
-(void)submitBlack:(NSString*)user_id;
//14黑名单列表
-(void)blackList:(int)page limit:(int)limit;
//15移除黑名单
-(void)removeBlack:(NSString*)user_id;
//16我的动态列表
-(void)mySaidList:(int)page limit:(int)limit;
//17我的粉丝
-(void)myFansList:(int)page limit:(int)limit;
//18我的关注
-(void)myAttentionList:(int)page limit:(int)limit;
//19消息列表
-(void)messageList:(int)page limit:(int)limit;
//20查看对方行程
-(void)OjourneyList:(NSString*)user_id page:(int)page limit:(int)limit;
//21删除动态
-(void)delMySaid:(NSString*)said_id;
//22查看对方行程详情
-(void)OjourneyDetail:(NSString*)id lat:(NSString*)lat lng:(NSString*)lng;
//23动态搜索列表
-(void)searchSaidList:(NSString*)keyword page:(int)page limit:(int)limit;
//24判断是否有新消息
-(void)isNewMessage;

//发现部分
//1指南列表
-(void)guideList:(int)page limit:(int)limit;
//2指南详情
-(void)guideDetail:(NSString*)id lat:(double)lat lng:(double)lng;
//3搜索指南
-(void)guideSearch:(NSString*)keyword page:(int)page limit:(int)limit;
//4排行列表
-(void)rankList;
//5地区列表
-(void)areaList:(NSString*)category_id;
//6查看排行列表
-(void)topList:(NSString*)area_id category_id:(NSString*)category_id;
//7查看感兴趣的商家列表
-(void)interestShopList:(NSString*)id category_id:(NSString*)category_id;
//8查看top10下商家列表
-(void)shopListByTop:(NSString*)top_id lat:(NSString*)lat lng:(NSString*)lng;




//目的地
-(void)destinationInfo:(NSString*)id;


-(void) test;
-(void) test:(NSString*)d;
-(void) version:(NSString*)appleID;
@end


