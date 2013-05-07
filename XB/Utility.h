//
//  Utility.h
//  shenbian
//
//  Created by MagicYang on 10-11-25.
//  Copyright 2010 personal. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utility : NSObject {

}

// 绘图相关
+ (void)drawUserLevel:(NSInteger)level withRect:(CGRect)rect;
+ (void)drawStars:(CGPoint)position score:(int)score;
+ (void)drawBorderText:(NSString *)text withColor:(UIColor *)color andBorderColor:(UIColor *)borderColor toRect:(CGRect)rect inContext:(CGContextRef)ctx;
+ (void)drawBreakLine:(CGRect)rect inContext:(CGContextRef)ctx;
+ (void)drawGradientWithBeginColor:(CGColorRef)beginColor andEndColor:(CGColorRef)endColor context:(CGContextRef)ctx inRect:(CGRect)rect;
+ (void)clipContext:(CGContextRef)context toRoundedCornerWithRect:(CGRect)rect andRadius:(CGFloat)radius;
+ (CGSize)scaleSize:(CGSize)oriSize toLimit:(CGFloat)limit;
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size withRadius:(CGFloat)radious;
+ (UIImage *)reverseImage:(UIImage *)image;

+ (UIColor *)colorWithHex:(NSInteger)color;
+ (NSString *)encodeParameter:(NSString *)param inWebView:(UIWebView *)webView;


// 字体
+ (void)listFonts;
+ (NSInteger)widthFromString:(NSString *)str withFont:(UIFont *)font;

+ (NSString*)formatedDistance:(int)distance;

+ (NSUInteger)pageWithTotal:(NSUInteger)total andCountPerPage:(NSUInteger)countPerPage;

// Date
+ (NSDateFormatter *)dateFormatter;
+ (NSDateFormatter *)dateFormatterWithString:(NSString *)dateFormat;
+ (NSString *)stringWithDate:(NSDate*)date;
+ (NSString *)stringWithDate:(NSDate *)date andFormatter:(NSDateFormatter *)formatter;
+ (NSDate *)dateFromString:(NSString*)date;
+ (NSString *)userFriendlyTimeFromUTC:(NSTimeInterval)time;

// Animation
+ (void)moveView:(UIView *)v p:(NSInteger)px;

+ (NSString *)formatFloat:(float)flt;
+ (NSInteger)roundoff:(float)flt;
+ (NSString *)removeTag:(NSString *)tag inText:(NSString *)text;
+ (NSString *)filePathWithName:(NSString*)fileName andDirectory:(NSString*)dir;
+ (NSString *)systemVersion;
+ (BOOL)iOS5Simida;

+ (NSString *)stringEncodedWithMD5:(NSString *)str;
+ (NSString *)stringEncodedWithMD5:(NSString *)str withEncoding:(NSStringEncoding)enc;

+ (wchar_t *)convertWCharWithNSString:(NSString *)str;

@end



int URLEncode(const char* str, const int strSize, char* result, const int resultSize);