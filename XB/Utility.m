//
//  Utility.m
//  shenbian
//
//  Created by MagicYang on 10-11-25.
//  Copyright 2010 personal. All rights reserved.
//

#import "Utility.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CommonCrypto/CommonDigest.h>




@implementation Utility


#pragma mark -
#pragma mark Draw

+ (void)drawUserLevel:(NSInteger)level withRect:(CGRect)rect
{
    NSString *levelImgName = [NSString stringWithFormat:@"userlevel_%d", level];
	UIImage *img = PNGImage(levelImgName);
	[img drawInRect:rect];
}

+ (void)drawStars:(CGPoint)point score:(int)score
{
	//total scores 10 maps to 5 stars
	const int width = 15;
	int stars = score / 2;
	int halfStars = score % 2;
	
	UIImage* starImg     = PNGImage(@"star_fill");
	UIImage* starZeroImg = PNGImage(@"star_zero");
	UIImage* starHalfImg = PNGImage(@"star_half");
	
	for(int i = 0; i< 5; i++){		
		if (i < stars) {
			[starImg drawAtPoint:point];
		}
		else if (i < stars + halfStars) {
			[starHalfImg drawAtPoint:point];
		}else {			
			[starZeroImg drawAtPoint:point];
		}
		point = CGPointMake(point.x + width, point.y);
	}
}

+ (void)drawBorderText:(NSString *)text withColor:(UIColor *)color andBorderColor:(UIColor *)borderColor toRect:(CGRect)rect inContext:(CGContextRef)ctx
{
    UIFont *font = [UIFont boldSystemFontOfSize:10];
    CGContextSaveGState(ctx);	
	CGContextSetLineWidth(ctx, 2);
//	CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
//	CGContextSetRGBStrokeColor(ctx, 0.87, 0.22, 0.16, 1.0);
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
	CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
    

    
	[text drawInRect:rect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentRight];
//    [text drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y) forWidth:30 withFont:font minFontSize:10 actualFontSize:NULL lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignCenters];
	CGContextSetTextDrawingMode(ctx, kCGTextFill);
	[text drawInRect:rect withFont:font lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentRight];
//    [text drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y) forWidth:30 withFont:font minFontSize:10 actualFontSize:NULL lineBreakMode:UILineBreakModeTailTruncation baselineAdjustment:UIBaselineAdjustmentAlignCenters];
	CGContextRestoreGState(ctx);
}

+ (void)drawBreakLine:(CGRect)rect inContext:(CGContextRef)ctx {
	CGContextSaveGState(ctx);
	CGContextSetRGBFillColor(ctx, 0.831, 0.831, 0.831, 1.0);
	CGContextFillRect(ctx, rect);
	CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
	CGContextFillRect(ctx, CGRectMake(rect.origin.x, rect.origin.y + 1, rect.size.width, 1));
//	CGContextFillRect(ctx, CGRectMake(4, y + 1, width, 1));
	CGContextRestoreGState(ctx);
}

+ (void)drawGradientWithBeginColor:(CGColorRef)beginColor andEndColor:(CGColorRef)endColor context:(CGContextRef)ctx inRect:(CGRect)rect {
	CGContextSaveGState(ctx);
	CGFloat locations[2] = {0.0, 1.0}; 
	CGColorRef colorRefs[2] = {beginColor, endColor};
	CFArrayRef colors = CFArrayCreate(NULL, (void *)colorRefs, 2, &kCFTypeArrayCallBacks);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
	CGPoint startPoint, endPoint;
	startPoint.x = 3.0;
	startPoint.y = 0.0;
	endPoint.x = 3.0;
	endPoint.y = rect.size.height;
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	
	CGContextRestoreGState(ctx);
	CFRelease(colors);
	CFRelease(colorSpace);
	CFRelease(gradient);
}

+ (void)clipContext:(CGContextRef)context toRoundedCornerWithRect:(CGRect)rect andRadius:(CGFloat)radius {
	CGContextBeginPath(context);
	CGFloat max_x = CGRectGetMaxX(rect);
	CGFloat max_y = CGRectGetMaxY(rect);
	CGFloat min_x = CGRectGetMinX(rect);
	CGFloat min_y = CGRectGetMinY(rect);
	CGFloat mid_x = CGRectGetMidX(rect);
	CGFloat mid_y = CGRectGetMidY(rect);
    
    CGContextMoveToPoint(context, min_x, mid_y);							// Start at left mid corner
	
    CGContextAddArcToPoint(context, min_x, min_y, mid_x, min_y, radius);	// left top corner
    CGContextAddArcToPoint(context, max_x, min_y, max_x, mid_y, radius);	// right top corner
    CGContextAddArcToPoint(context, max_x, max_y, mid_x, max_y, radius);	// right buttom corner
    CGContextAddArcToPoint(context, min_x, max_y, min_x, mid_y, radius);	// left buttom corner
    
    CGContextClosePath(context);
	CGContextClip(context);
}

+ (CGFloat)drawStar:(UIImage *)img atPoint:(CGPoint)point withSize:(CGSize)starSize andCount:(NSInteger)count {
	CGFloat x_begin = point.x;
	CGFloat partition = 3;
	for (int i = 0; i < count; i++) {
		[img drawInRect:CGRectMake(x_begin, point.y, starSize.width, starSize.height)];
		x_begin += starSize.width + partition;
	}
	return x_begin;
}

+ (CGSize)scaleSize:(CGSize)oriSize toLimit:(CGFloat)limit {
	if (oriSize.width < limit || oriSize.height < limit) {
		return oriSize;
	}
	
	int factorW = oriSize.width / limit;
	int factorH = oriSize.height / limit;
	int factor = MIN(factorW, factorH);
	return CGSizeMake(oriSize.width / factor, oriSize.height / factor);
}

+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size {
	if (!image) {
		return nil;
	}
	
	if (image.size.width <= size.width && image.size.height <= size.height) {
		return image;
	}
	
	CGRect newRect = CGRectZero;
	// caculate the new rect for clipping
	if(!CGSizeEqualToSize(image.size, size)) 
    {
        CGFloat widthFactor = size.width / image.size.width;
        CGFloat heightFactor = size.height / image.size.height;
		CGFloat scaleFactor = MAX(widthFactor, heightFactor);
		
        CGFloat scaledWidth  = image.size.width * scaleFactor;
        CGFloat scaledHeight = image.size.height * scaleFactor;
        
        // center the image
		CGPoint origin = CGPointZero;
        if(widthFactor > heightFactor)		origin.y = (size.height - scaledHeight) * 0.5;
        else if(widthFactor < heightFactor) origin.x = (size.width - scaledWidth) * 0.5;
		
		newRect.origin = origin;
		newRect.size.width  = scaledWidth;
		newRect.size.height = scaledHeight;
    }
	
	UIGraphicsBeginImageContext(newRect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0, newRect.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextRotateCTM(context, M_PI / 2);
	CGContextDrawImage(context, newRect, image.CGImage);
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

+ (UIImage*)clipImage:(UIImage*)image toSize:(CGSize)size {
	BOOL needClip = image.size.width > size.width && image.size.height > size.height;
	if (!image && !needClip) {
		return image;
	}
	
	CGRect newRect = CGRectZero;
	// caculate the new rect for clipping
	if(!CGSizeEqualToSize(image.size, size)) 
    {
        CGFloat widthFactor = size.width / image.size.width;
        CGFloat heightFactor = size.height / image.size.height;
		CGFloat scaleFactor = MAX(widthFactor, heightFactor);
		
        CGFloat scaledWidth  = image.size.width * scaleFactor;
        CGFloat scaledHeight = image.size.height * scaleFactor;
        
        // center the image
		CGPoint origin = CGPointZero;
        if(widthFactor > heightFactor)		origin.y = (size.height - scaledHeight) * 0.5;
        else if(widthFactor < heightFactor) origin.x = (size.width - scaledWidth) * 0.5;
		
		newRect.origin = origin;
		newRect.size.width  = scaledWidth;
		newRect.size.height = scaledHeight;
    }
	
	UIGraphicsBeginImageContext(size);
	[image drawInRect:newRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

// TODO: Merge this method with above
+ (UIImage *)clipImage:(UIImage *)image toSize:(CGSize)size withRadius:(CGFloat)radious {
	if (!image) {
		return nil;
	}
	
	CGRect newRect = CGRectZero;
	// caculate the new rect for clipping
	if(!CGSizeEqualToSize(image.size, size)) 
    {
        CGFloat widthFactor = size.width / image.size.width;
        CGFloat heightFactor = size.height / image.size.height;
		CGFloat scaleFactor = MAX(widthFactor, heightFactor);
		
        CGFloat scaledWidth  = image.size.width * scaleFactor;
        CGFloat scaledHeight = image.size.height * scaleFactor;
        
        // center the image
		CGPoint origin = CGPointZero;
        if(widthFactor > heightFactor)		origin.y = (size.height - scaledHeight) * 0.5;
        else if(widthFactor < heightFactor) origin.x = (size.width - scaledWidth) * 0.5;
		
		newRect.origin = origin;
		newRect.size.width  = scaledWidth;
		newRect.size.height = scaledHeight;
    }
	
	UIGraphicsBeginImageContext(size);
	[Utility clipContext:UIGraphicsGetCurrentContext() toRoundedCornerWithRect:newRect andRadius:radious];
	[image drawInRect:newRect];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

+ (UIImage *)reverseImage:(UIImage *)image {
	UIGraphicsBeginImageContext(image.size);
//	CGAffineTransform transform = CGAffineTransformIdentity;
//	transform = CGAffineTransformRotate(transform, M_PI);
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return imageCopy;
}

+ (UIColor *)colorWithHex:(NSInteger)color {
	int r = (color & 0xFF0000) >> 16;
	int g = (color & 0xFF00) >> 8;
	int b = color & 0xFF;
	return [UIColor colorWithRed:r*1.0/255 green:g*1.0/255 blue:b*1.0/255 alpha:1.0];
}


#pragma mark -
#pragma mark Encoding
+ (NSString *)encodeParameter:(NSString *)param inWebView:(UIWebView *)webView {
	return [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"javascript:encodeURIComponent(\"%@\")", param]];
}


#pragma mark -
+ (NSString*)formatedDistance:(int)distance
{
    if (distance < 1000) {
        return [NSString stringWithFormat:@"%dm",distance];
    }else if(distance < 20*1000){
        return [NSString stringWithFormat:@"%.1fkm",distance/1000.0];
    }else{
        return @"20km+";
    }
}

+ (NSUInteger)pageWithTotal:(NSUInteger)total andCountPerPage:(NSUInteger)countPerPage
{
	BOOL isAdd = total % countPerPage != 0;
	return isAdd ? total / countPerPage + 1 : total / countPerPage;
}

#pragma mark -
#pragma mark Font
+ (void)listFonts {
	NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
	NSArray *fontNames;
	NSInteger family, j;
	int numFamilies = [familyNames count];
	int numFonts = 0;	// tallied below
	printf("static char* fontNames[] = {");
	for (family=0; family < numFamilies; ++family)
	{
		//Log(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
		fontNames = [[NSArray alloc] initWithArray: [UIFont fontNamesForFamilyName: [familyNames objectAtIndex: family]]];
		for (j=0; j<[fontNames count]; ++j)
		{
			DLog(@"\"%@\", ", [fontNames objectAtIndex:j]);
			++numFonts;
		}
		[fontNames release];
	}
	[familyNames release];
	printf("};");
	printf("#define NUMFONTS %d\n", numFonts);
}

+ (NSInteger)widthFromString:(NSString *)str withFont:(UIFont *)font
{
    CGSize size = [str sizeWithFont:font];
    return size.width;
}


#pragma mark -
#pragma mark Date
+ (NSDateFormatter *)dateFormatter {
	NSDateFormatter *df = [NSDateFormatter new];
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
	[df setLocale:locale];
	[df setDateFormat:@"yyyy-MM-dd"];
	[locale release];
	return [df autorelease];
}

+ (NSDateFormatter *)dateFormatterWithString:(NSString *)dateFormat {
	NSDateFormatter *df = [NSDateFormatter new];
	NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
	[df setLocale:locale];
	[df setDateFormat:dateFormat];
	[locale release];
	return [df autorelease];
}

+ (NSString*)stringWithDate:(NSDate*)date {
	return [[self dateFormatter] stringFromDate:date];
}

+ (NSString *)stringWithDate:(NSDate *)date andFormatter:(NSDateFormatter *)formatter {
	return [formatter stringFromDate:date];
}

+ (NSDate*)dateFromString:(NSString*)date {
	return [[self dateFormatter] dateFromString:date];
}


+ (NSString *)userFriendlyTimeFromUTC:(NSTimeInterval)time 
{
	// 时间的展示策略：
	// 30分钟之内：以分钟计，如12分钟前
	// 24小时之内，以小时计：20小时前
	// 7天内，以天计：5天前
	// 其他用日期
	
	static NSTimeInterval Within60Mins  = 60 * 60;
	static NSTimeInterval Within24Hours = 24 * 60 * 60;
	static NSTimeInterval Within7Days   = 7 * 24 * 60 * 60;
	
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval since = now - time;
	if (since <= Within60Mins) {
		return [NSString stringWithFormat:@"%d分钟前", (int)(since / 60)];
	} else if (since > Within60Mins && since <= Within24Hours) {
		return [NSString stringWithFormat:@"%d小时前", (int)(since / 60 / 60)];
	} else if (since > Within24Hours && since <= Within7Days) {
		return [NSString stringWithFormat:@"%d天前", (int)(since / 60 / 60 / 24)];
	} else {
//		return [Utility stringWithDate:[NSDate dateWithTimeIntervalSince1970:time]];
		return @"7天前";
	}
}

#pragma mark -
#pragma mark Animation
+ (void)moveView:(UIView *)v p:(NSInteger)px {
	CGRect rect =  v.frame;
	[v setFrame:CGRectMake(rect.origin.x, rect.origin.y + px, rect.size.width, rect.size.height)];
}


+ (NSString *)formatFloat:(float)flt {
	NSString *fltStr = [NSString stringWithFormat:@"%.1f", flt];
	NSArray *strs = [fltStr componentsSeparatedByString:@"."];
	if ([strs count] == 2) {
		NSString *decimalStr = [strs objectAtIndex:1];
		if ([decimalStr intValue] == 0) {
			return [strs objectAtIndex:0];
		}
	}
	
	return fltStr;
}

+ (NSInteger)roundoff:(float)flt {
	NSString *fltStr = [NSString stringWithFormat:@"%.1f", flt];
	NSArray *strs = [fltStr componentsSeparatedByString:@"."];
	if ([strs count] == 2) {
		NSInteger var = [[strs objectAtIndex:0] intValue];
		NSString *decimalStr = [strs objectAtIndex:1];
		if ([decimalStr intValue] >= 5) {
			return var + 1;
		} else {
			return var;
		}
	}
	
	return [fltStr intValue];
}

+ (NSString *)removeTag:(NSString *)tag inText:(NSString *)text {
	NSString *tagPrefix = [NSString stringWithFormat:@"<%@>", tag];
	NSString *tagSuffix = [NSString stringWithFormat:@"</%@>", tag];
	text = [text stringByReplacingOccurrencesOfString:tagPrefix withString:@""];
	text = [text stringByReplacingOccurrencesOfString:tagSuffix withString:@""];
	
	// HTML特殊字符替换
	text = [text stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	text = [text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	text = [text stringByReplacingOccurrencesOfString:@"&#39;" withString:@"\'"];
	
	return text;
}

+ (NSString*)filePathWithName:(NSString*)fileName andDirectory:(NSString*)dir {
	NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *dirPath = [docPath stringByAppendingFormat:@"/%@", dir];
	if(![fileManager fileExistsAtPath:dirPath]) {
		[fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:nil];
	}
	return [dirPath stringByAppendingFormat:@"/%@", fileName];
}

+ (NSString *)systemVersion {
    int version = [[[UIDevice currentDevice] systemVersion] intValue];
    if (version >= 4) {
        return @"4";    // iOS4.x都为4
    } else {
        return @"3";    // iOS4.0以下的都归为3
    }
}

+ (BOOL)iOS5Simida
{
    return [[[UIDevice currentDevice] systemVersion] intValue] >= 5;
}


+ (NSString *)stringEncodedWithMD5:(NSString *)str
{
	return [[self class] stringEncodedWithMD5:str withEncoding:NSUTF8StringEncoding];
//    const char *cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5( cStr, strlen(cStr), result );
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3], 
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];  
}

+ (NSString *)stringEncodedWithMD5:(NSString *)str withEncoding:(NSStringEncoding)enc
{
	NSData *data = [str dataUsingEncoding:enc];
    const char *cStr = [data bytes];
	int length = [data length];
    unsigned char result[16];
    CC_MD5( cStr, length, result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];	
}

+ (wchar_t *)convertWCharWithNSString:(NSString *)str
{
    const char  *cString = [str cStringUsingEncoding:NSUTF8StringEncoding];
    //char转wchar_t
    setlocale(LC_CTYPE, "UTF-8");
    int iLength = mbstowcs(NULL, cString, 0);    
    wchar_t *stTmp = (wchar_t *)malloc(iLength + 1);
    memset(stTmp, 0, iLength + 1);
    mbstowcs((wchar_t *)stTmp, cString, iLength);
    stTmp[iLength] = 0;
    return stTmp;
}

@end


/************************************************ 
 * 把字符串进行URL编码。 
 * 输入： 
 * str: 要编码的字符串 
 * strSize: 字符串的长度。这样str中可以是二进制数据 
 * result: 结果缓冲区的地址 
 * resultSize:结果地址的缓冲区大小(如果str所有字符都编码，该值为strSize*3) 
 * 返回值： 
 * >0: result中实际有效的字符长度， 
 * 0: 编码失败，原因是结果缓冲区result的长度太小 
 ************************************************/
int URLEncode(const char* str, const int strSize, char* result, const int resultSize)
{
	int i;
	int j = 0; /* for result index */
	char ch;
	
	if ((str == NULL) || (result == NULL) || (strSize <= 0) || (resultSize <= 0))
	{
		return 0;
	}
	
	for (i = 0; (i < strSize) && (j < resultSize); i++)
	{
		ch = str[i];
		if ((ch >= 'A') && (ch <= 'Z'))
		{
			result[j++] = ch;
		}
		else if ((ch >= 'a') && (ch <= 'z'))
		{
			result[j++] = ch;
		}
		else if ((ch >= '0') && (ch <= '9'))
		{
			result[j++] = ch;
		}
		else if (ch == ' ')
		{
			result[j++] = '+';
		}
		else
		{
			if (j + 3 < resultSize)
			{
				sprintf(result + j, "%%%02X", (unsigned char) ch);
				j += 3;
			}
			else
			{
				return 0;
			}
		}
	}
	
	result[j] = '\0';
	return j;
}