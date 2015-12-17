//
//  NSString+Category.h
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (Category)

#pragma mark - BOOL
- (BOOL)isPureLetter;
- (BOOL)isPureNumber;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndWith:(NSString *)string;
- (BOOL)isValidEmail;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;

#pragma mark - Coding
- (NSData *)UTF8Coding;
+ (NSString *)UTF8Decoding:(NSData *)data;
- (NSString *)sha1;
- (NSString *)md5;
- (NSString *)base64Coding;

#pragma mark - string operating
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString ;
- (NSString *)removeSpacesFromString;
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar ;
- (NSString *)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)getFirstLetter;
@end
