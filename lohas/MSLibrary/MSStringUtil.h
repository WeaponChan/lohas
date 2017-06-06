#import <UIKit/UIKit.h>


@interface NSString (MSStringUtils)
- (NSString*)encodeAsURIComponent;
- (NSString *)decodeURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;
+ (NSString*)localizedString:(NSString*)key;
+ (NSString*)base64encode:(NSString*)str;
- (NSString *) md5;
- (BOOL) isUrl;
-(NSString*)urlEncoded;
-(NSString*)urlDecoded;
-(NSString*) formattedTime:(BOOL)isShort;
-(NSString*) formattedOrderTime;
-(NSString*)trim;
- (NSString*) filterHtml;
- (BOOL) isValidEmail;
- (BOOL) isValidID;


@end


