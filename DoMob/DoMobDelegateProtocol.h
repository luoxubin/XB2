//
//  DoMobDelegateProtocol.h
//  DoMob iPhone/iPad SDK
//
//  Defines the DoMob delegate protocol

#import <UIKit/UIKit.h>

@class DoMobView;

typedef enum {
	//从右往左翻转
	DomobADTransitionFlip = 0,
	//放大
	DomobADTransitionZoom,           
	//淡入淡出
	DomobADTransitionFadeIn,         
	//碎片
	DomobADTransitionFragment,       
	//从右往左平移
	DomobADTransitionMoveFromRight,  
	//从左往右平移
	DomobADTransitionMoveFromLeft,   
	//从以上效果中随机选择一种
	DomobADTransitionRadom,
	DomobADTransitionCount
} DomobADTransitionType;
@protocol DoMobDelegate<NSObject>
@required

#pragma mark -
#pragma mark required methods

// 发送广告请求包的时候，设置开发者id；开发者id可以从http://wwww.domob.cn 获取。
// 返回值:从http://wwww.domob.cn 获取的开发者id。
// 注意:该值不应当为nil或空字符串，否则无法返回在正确的广告。
- (NSString *)domobPublisherIdForAd:(DoMobView *)doMobView;

// 返回当前视图的控制器，DoMobView应当是当前控制器所连接的视图的子视图。
// 确保返回的是当前顶层的控制器(例如:应用于NavigationController等应用，最好返回NavigationController作为根控制器)。
// 返回值:当前View的控制器。
// 注意:该值不可以为nil，否则无法展现点击内容。
- (UIViewController *)domobCurrentRootViewControllerForAd:(DoMobView *)doMobView;

@optional

#pragma mark -
#pragma mark optional control methods
// 设置广告视图的背景色，该设置只在服务器没有返回背景颜色值的情况下生效。
// doMobView:广告视图对象，用于标识哪个对象使用该函数返回值。
// 返回值:表示颜色的UIColor对象，默认值为(rgba=7B83A0FF)。
- (UIColor *)domobAdBackgroundColorForAd:(DoMobView *)doMobView;

// 设置广告视图中文字的主显示颜色，该设置只在服务器没有返回文字颜色值的情况下生效。
// doMobView:广告视图对象，用于标识哪个对象使用该函数返回值。
// 返回值:表示颜色的UIColor对象，默认值为白色(rgba=FFFFFFFF)。
- (UIColor *)domobPrimaryTextColorForAd:(DoMobView *)doMobView;


// 设置广告切换动画类型
-(DomobADTransitionType)domobTransitionType:(DoMobView *)doMobView;
#pragma mark -
#pragma mark optional Info methods
// 设置广告内容的关键词，服务器根据该关键词返回最合适的广告。
// 返回值:关键词的组合字符串，多个关键词使用”,”分隔，例如：”iPhone,Game”。
- (NSString *)domobKeywords;

// 设置邮编，服务器根据该邮编返回最合适的广告。
// 返回值:开发者指定的邮编字符串。例如：“100032”。
- (NSString *)domobPostalCode;

// 设置出生日期，服务器根据该生日返回最合适的广告。
// 返回值:开发者指定的出生日期字符串。格式为“YYYYMMDD”，例如：“20101220”。
- (NSString *)domobDateOfBirth;

// 设置性别，服务器根据性别返回最合适的广告。
// 返回值:开发者指定的性别字符串。例如：“m”/“f”。m表示male, f表示female。
- (NSString *)domobGender;

// 设置当前用户经度，该值与 domobLocationLatitude结合使用，服务器根据经纬度返回最合适的广告。
// 该值主要应用于使用GPS功能的应用程序。
// 返回值:开发者通过程序获取的经度值。
- (double)domobLocationLongitude;

// 设置当前用户纬度，该值与 domobLocationLongitude 结合使用，服务器根据经纬度返回最合适的广告。
// 该值主要应用于使用GPS功能的应用程序。
// 返回值:开发者通过程序获取的纬度值。
- (double)domobLocationLatitude;

// 设置获取经纬度时的时间戳，服务器根据该值返回最合适的广告。 
// 该值主要应用于使用GPS功能的应用程序。
// 返回值:开发者能过程序获取的时间戳。
- (NSDate *)domobLocationTimestamp;

// 是开发者用来区分不同广告控件的标识，可以根据spot来区分应用中不同地方的广告控件的效果
// 返回值:开发者自定义的字符串。
- (NSString *)domobSpot:(DoMobView *)doMobView;

#pragma mark -
#pragma mark optional Connection methods
// 当第一次成功接收到广告后通知应用程序。开发者可以在此时将广告视图添加到当前的View中。该回调只会调用一次。
- (void)domobDidReceiveAdRequest:(DoMobView *)doMobView;

// 当后续成功接收广告后通知应用程序。
- (void)domobDidReceiveRefreshedAd:(DoMobView *)doMobView;

// 当第一次接收广告失败后通知应用程序。该回调只会调用一次。
- (void)domobDidFailToReceiveAdRequest:(DoMobView *)doMobView;

// 当后续的接收广告失败后通知应用程序。
- (void)domobDidFailToReceiveRefreshedAd:(DoMobView *)doMobView;

// 全屏显示广告之前，发送该通知；开发者可以在此停止应用程序的相关动画、时间敏感时间的交互等。
- (void)domobWillPresentFullScreenModalFromAd:(DoMobView *)doMobView;

// 全屏显示广告之后，发送该通知。
- (void)domobDidPresentFullScreenModalFromAd:(DoMobView *)doMobView;

// 退出全屏广告显示之前，发送该通知。
- (void)domobWillDismissFullScreenModalFromAd:(DoMobView *)doMobView;

// 退出全屏广告显示之前，发送该通知。开发者可以在此恢复应用程序的相关动画、时间敏感时间的交互等。
- (void)domobDidDismissFullScreenModalFromAd:(DoMobView *)doMobView;

#pragma mark -
#pragma mark optional control ad request interval methods
// 设置广告请求的刷新时间，该值必须大于20秒，如小于20秒，则使用默认值20秒。
// 设置成0则只请求一次广告，不再刷新
// 注意：如果在服务器端设置成使用客户端的刷新时间，则使用该函数的返回值，否则使用服务器端设置的值。
// 返回值:开发者设定的时间值
- (NSInteger)domobRefreshIntervalForAd:(DoMobView *)doMobView;


@end