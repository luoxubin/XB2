//
//  DoMobViewController.m
//  DoMob iPhone/iPad SDK
//

#import "DoMobViewController.h"
#import "DoMobView.h"

@implementation DoMobViewController

@synthesize currentViewController;
@synthesize doMobAd;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)awakeFromNib {
	CGSize adSize = self.view.frame.size;
	self.view.hidden = YES;
	// 初始化广告控件，发送广告请求
	self.doMobAd = [DoMobView requestDoMobViewWithSize:adSize WithDelegate:self];
}

- (void)dealloc {
	self.doMobAd.doMobDelegate = nil;
	self.doMobAd = nil;
    [super dealloc];
}

// 发送广告请求包的时候，设置开发者id；开发者id可以从http://www.domob.cn 获取。
// 返回值:从http://www.domob.cn 获取的开发者id。
// 注意:该值不应当为nil或空字符串，否则无法返回在正确的广告。
- (NSString *)domobPublisherIdForAd:(DoMobView *)doMobView {
	// 请到www.domob.cn网站注册获取自己的publisher id
	return @"56OJyM1ouMGoULfJaL";
}

// 返回当前视图的控制器，DoMobView应当是当前控制器所连接的视图的子视图。
// 确保返回的是当前顶层的控制器(例如:应用于NavigationController等应用，最好返回NavigationController作为根控制器)。
// 返回值:当前View的控制器。
// 注意:该值不可以为nil，否则无法展现点击内容。
- (UIViewController *)domobCurrentRootViewControllerForAd:(DoMobView *)doMobView {
	return currentViewController;
}

// 当第一次成功接收到广告后通知应用程序。开发者可以在此时将广告视图添加到当前的View中。该回调只会调用一次。
- (void)domobDidReceiveAdRequest:(DoMobView *)doMobView {
	NSLog(@"DoMob: Did receive ad in DoMobViewController");
	[self.view addSubview:doMobAd];
	self.view.hidden = NO;
}

// 当第一次接收广告失败后通知应用程序。开发者可以在此将广告视图控件移出当前View。该回调只会调用一次。
- (void)domobDidFailToReceiveAdRequest:(DoMobView *)doMobView {
	NSLog(@"DoMob: Did fail to receive ad in DoMobViewController");
}

/*
// 是开发者用来区分不同广告控件的标识，可以根据spot来区分应用中不同地方的广告控件的效果
// 返回值:开发者自定义的字符串。
- (NSString *)domobSpot:(DoMobView *)doMobView
{
	return @"";
}
*/

@end
