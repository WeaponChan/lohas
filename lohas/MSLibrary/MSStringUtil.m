#import "MSStringUtil.h"

//#import "SBJson.h"
#import "NSObject+SBJson.h"
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 

@implementation NSString (MSStringUtils)
- (NSString*)encodeAsURIComponent
{
	const char* p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++) {
		unsigned char c = *p;
		if ('0' <= c && c <= '9' || 'a' <= c && c <= 'z' || 'A' <= c && c <= 'Z' || c == '-' || c == '_') {
			[result appendFormat:@"%c", c];
		} else {
			[result appendFormat:@"%%%02X", c];
		}
	}
	return result;
}

- (NSString *)decodeURIComponent
{
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString*)base64encode:(NSString*)str 
{
    if ([str length] == 0)
        return @"";

    const char *source = [str UTF8String];
    int strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;

    NSUInteger length = 0;
    NSUInteger i = 0;

    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString*)escapeHTML
{
	NSMutableString* s = [NSMutableString string];
	
	int start = 0;
	int len = [self length];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}

- (NSString*)unescapeHTML
{
	NSMutableString* s = [NSMutableString string];
	NSMutableString* target = [self mutableCopy];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	
	return s;
}

- (NSString *) md5
{
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			]; 
}

+ (NSString*)localizedString:(NSString*)key
{
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
}

-(NSString*)urlEncoded {
    
    NSString *escapedUrlString = [(NSString *)self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return escapedUrlString;
    
}

-(NSString*)urlDecoded {
    
    NSString *cleanUrlString =  [(NSString *)self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return cleanUrlString;
    
}

-(NSString*)trim {
    NSString *cleanString = [(NSString *)self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}




-(NSString*) formattedTime:(BOOL)isShort
{
    static NSDateFormatter *dateFormatterfrom = nil;
    static NSDateFormatter *dateFormatterto = nil;
    static NSDateFormatter *dateFormatterto2 = nil;
    if (dateFormatterfrom == nil) {
        dateFormatterfrom = [[NSDateFormatter alloc] init];
        [dateFormatterfrom setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    }
    
    if (dateFormatterto == nil) {
        dateFormatterto = [[NSDateFormatter alloc] init];
        [dateFormatterto setDateFormat:@"yyyy年M月d日"];
    }
    
    if (dateFormatterto2 == nil) {
        dateFormatterto2 = [[NSDateFormatter alloc] init];
        [dateFormatterto2 setDateFormat:@"M月d日"];
    }
    
    NSDate *date = [dateFormatterfrom dateFromString:self];
    NSString* formattedString = nil;
    if(isShort) {
        formattedString = [dateFormatterto2 stringFromDate:date];
    } else {
        formattedString = [dateFormatterto stringFromDate:date];
    }
    
    return formattedString;
}


-(NSString*) formattedOrderTime
{
    static NSDateFormatter *dateFormatterfrom = nil;
    static NSDateFormatter *dateFormatterto3 = nil;
    
    if (dateFormatterfrom == nil) {
        dateFormatterfrom = [[NSDateFormatter alloc] init];
        //[dateFormatterfrom setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatterfrom setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    }
    
    if (dateFormatterto3 == nil) {
        dateFormatterto3 = [[NSDateFormatter alloc] init];
        [dateFormatterto3 setDateFormat:@"yyyy年M月d日 HH:mm:ss"];
    }
    
    
    NSDate *date = [dateFormatterfrom dateFromString:self];
    NSString* formattedString = nil;

    formattedString = [dateFormatterto3 stringFromDate:date];
    if(formattedString && ![formattedString isEqual:[NSNull null]])
    {
        return formattedString;
    }
    return self;
}



@end



