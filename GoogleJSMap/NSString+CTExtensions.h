//
//  NSString+CTExtensions.h
//  CTRIP_WIRELESS
//
//  Created by Haoran Chen on 10/16/13.
//  Copyright (c) 2013 携程. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CTExtensions)

/**
 *  URL Encode字符串 (非stringByAddingPercentEscapesUsingEncoding方式)
 *
 *  @return URL encode后的字符串
 */
- (NSString *)stringByCFURLEncoding;

/**
 *  URL Dncode字符串 (非stringByReplacingPercentEscapesUsingEncoding方式)
 *
 *  @return URL encode后的字符串
 */
- (NSString *)stringByCFURLDecoding;

/**
 *  生成字符串对应的MD5值
 *
 *  @return 字符串对应的MD5
 */
- (NSString *)md5HexDigest;

/**
 *  生成字符串对应的SHA1值
 *
 *  @return 字符串对应的SHA1值
 */
- (NSString *)sha1HexDigest;

/**
 *  消除字符串中的空格和换行
 *
 *  @return 消除了的空格和换行的字符串
 */
- (NSString *)trimmedString;

-(BOOL)isEmpty;
@end
