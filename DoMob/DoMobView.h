//
//  DoMobView.h
//  DoMob iPhone/iPad SDK
//

#import <UIKit/UIKit.h>

@protocol DoMobDelegate;

@interface DoMobView : UIView

// 定义广告视图的大小，该大小主要应用于iPhone的应用程序。
#define DOMOB_SIZE_320x48		CGSizeMake(320,48)

// 定义广告视图大小，该大小主要应于iPad的应用程序。
#define DOMOB_SIZE_320x270		CGSizeMake(320,270)
#define DOMOB_SIZE_488x80		CGSizeMake(488,80)
#define DOMOB_SIZE_748x110		CGSizeMake(748,110)

@property (assign) id<DoMobDelegate> doMobDelegate;


// 初始化广告控件, 发送广告请求， 返回广告视图对象
// sizeofAd:显示广告区域的CGSize大小。
// delegate:DoMobDelegate对象，广告视图将执行DomobDelegate中定义的方法。
// 返回值:广告视图对象。
+ (DoMobView *)requestDoMobViewWithSize:(CGSize)sizeofAd WithDelegate:(id<DoMobDelegate>) delegate;

// 使用 DOMOB_SIZE_320x48 大小初始化广告控件, 发送广告请求， 返回广告视图对象
// delegate:DoMobDelegate对象，广告视图将执行DomobDelegate中定义的方法。
// 返回值:广告视图对象。
+ (DoMobView *)requestDoMobViewWithDelegate:(id <DoMobDelegate>)delegate;

// 返回SDK版本
// 返回值:SDK版本字符串
+ (NSString *)version;


@end
