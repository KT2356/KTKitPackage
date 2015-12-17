//
//  NSString+Category.m
//  KTKitPackageDemo
//
//  Created by KT on 15/12/16.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import "pinyin.h"

@implementation NSString (Category)

#pragma mark - BOOL
- (BOOL)isPureLetter {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)isPureNumber {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)containsString:(NSString *)subString {
    return [self rangeOfString:subString].location == NSNotFound ? NO : YES;
}

- (BOOL)isBeginsWith:(NSString *)string {
    return [self hasPrefix:string];
}

- (BOOL)isEndWith:(NSString *)string {
    return [self hasSuffix:string];
}

- (BOOL)isValidEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

- (BOOL)isVAlidPhoneNumber {
    NSString *phoneRegex = @"\\d{3}-{0,1}\\d{8}|\\d{4}-{0,1}\\d{7,8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidUrl {
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}


#pragma mark - Coding
//UTF8
- (NSData *)UTF8Coding {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)UTF8Decoding:(NSData *)data {
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

//SHA1
- (NSString *)sha1 {
    const char *ptr = [self UTF8String];
    int i =0;
    int len = (int)strlen(ptr);
    Byte byteArray[len];
    while (i!=len) {
        unsigned eachChar = *(ptr + i);
        unsigned low8Bits = eachChar & 0xFF;
        byteArray[i] = low8Bits;
        i++;
    }
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(byteArray, len, digest);
    NSMutableString *hex = [NSMutableString string];
    for (int i=0; i<20; i++)
        [hex appendFormat:@"%02x", digest[i]];
    NSString *immutableHex = [NSString stringWithString:hex];
    return immutableHex;
}

//MD5
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

//Base64
- (NSString *)base64Coding{
    NSData *data = [NSData dataWithBytes:[self UTF8String]
                                  length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    return [[NSString alloc] initWithData:mutableData encoding:NSUTF8StringEncoding];
}

//3DES
- (NSString *)tripeDesCodingWithSecret:(NSString *)secret{
    NSString *hexString = secret;
    int j=0;
    Byte bytes[24];
    for(int i=0;i<[hexString length];i++) {
        int int_ch;
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16;
        else
            int_ch1 = (hex_char1-87)*16;
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i];
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48);
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55;
        else
            int_ch2 = hex_char2-87;
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;
        j++;
    }
    
    const void *vplainText;
    size_t plainTextBufferSize; {
        NSData* data = [secret dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       bytes,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    Byte *stringBytes = (Byte *)[myData bytes];
    NSArray *HEX_DIGITS = @[ @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f" ];
    NSUInteger i=0;
    NSMutableString *result=[[NSMutableString alloc] init];
    for (i=0; i<40; i++) {
        [result appendFormat:@"%@",(HEX_DIGITS[(stringBytes[i] >> 4 & 0xF)])];
        [result appendFormat:@"%@",(HEX_DIGITS[(stringBytes[i] & 0xF)])];
    }
    return result;
}

#pragma mark - string operating
//拼接字符串
- (NSString *)addString:(NSString *)string {
    if(!string || string.length == 0)
        return self;
    return [self stringByAppendingString:string];
}

//指定字符删除
- (NSString *)removeSubString:(NSString *)subString {
    if ([self containsString:subString]) {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

//删除空格
- (NSString *)removeSpacesFromString {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

//字符替换
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar {
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

//获取截取字符串
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end {
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

//获取首字母
- (NSString *)getFirstLetter {
    NSString *pinyinLetter;
    NSString *subString = [self substringWithRange:NSMakeRange(0,1)];
    const char *cString = [subString UTF8String];
    //汉字
    if (strlen(cString) == 3) {
        pinyinLetter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([self characterAtIndex:0])]uppercaseString];
    }
    else {
        pinyinLetter = [subString uppercaseString];
        NSString *regex = @"[A-Z]";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if (![predicate evaluateWithObject:pinyinLetter]) {
            pinyinLetter = @"#";
        }
    }
    return pinyinLetter;
}

@end
