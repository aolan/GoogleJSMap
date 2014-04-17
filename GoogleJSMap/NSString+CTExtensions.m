//
//  NSString+CTExtensions.m
//  CTRIP_WIRELESS
//
//  Created by Haoran Chen on 10/16/13.
//  Copyright (c) 2013 携程. All rights reserved.
//

#import "NSString+CTExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CTExtensions)

- (NSString *)stringByCFURLEncoding
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                     (CFStringRef)self,
                                                                     NULL,
                                                                     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]%",
                                                                     kCFStringEncodingUTF8));
}

- (NSString *)stringByCFURLDecoding
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
}

- (NSString *)md5HexDigest
{
    const char *cString = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, strlen(cString), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; ++i)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

- (NSString *)sha1HexDigest
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i)
    {
        [hash appendFormat:@"%02x", digest[i]];
    }
    
    return hash;
}

- (NSString *)trimmedString
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(BOOL)isEmpty{
    return self == nil || self.length == 0 || [self trimmedString].length == 0;
}
@end
