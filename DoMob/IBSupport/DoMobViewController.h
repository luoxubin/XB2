//
//  DoMobViewController.h
//  DoMob iPhone/iPad SDK
//

#import <UIKit/UIKit.h>
#import "DoMobDelegateProtocol.h"

@class DoMobView;

@interface DoMobViewController : UIViewController<DoMobDelegate> {
	
	// 广告控件，使用输出口在IB中指定广告的显示位置。
	DoMobView *doMobAd;
	
	UIViewController *currentViewController;
}

// 当前的控制器，DoMobView应当是当前控制器所连接的视图的子视图
@property (nonatomic, assign)IBOutlet UIViewController *currentViewController;

@property (nonatomic, retain)DoMobView *doMobAd;

@end
