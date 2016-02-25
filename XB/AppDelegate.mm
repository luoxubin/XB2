//
//  AppDelegate.m
//  XB
//
//  Created by luoxubin on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "XBTabBarController.h"
#import "SingleWebviewController.h"
#import "MultiWebViewController.h"
#import "VideoPlayerViewController.h"
#import "CommonViewController.h"
#import "HTTPServer.h"
#import "DDTTYLogger.h"


@implementation AppDelegate

@synthesize window;
@synthesize tabBarController;



- (void)dealloc
{
    [window release];
    [tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 启动一个轻量级的httpsverver
    // Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// Create server using our custom MyHTTPServer class
	httpServer = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer setType:@"_http._tcp."];
	
	// Normally there's no need to run our server on any specific port.
	// Technologies like Bonjour allow clients to dynamically discover the server's port at runtime.
	// However, for easy testing you may want force a certain port so you can just hit the refresh button.
	[httpServer setPort:12345];
	
	// Serve files from our embedded Web folder
	
    
    NSString *pathPrefix = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *webPath = [pathPrefix stringByAppendingPathComponent:kPathDownload];
	DDLogInfo(@"Setting document root: %@", webPath);
	
	[httpServer setDocumentRoot:webPath];
	
	// Start the server (and check for problems)
	
	NSError *error;
	if(![httpServer start:&error])
	{
		DDLogError(@"Error starting HTTP Server: %@", error);
	}
    
    SingleWebviewController *firstVC = [[SingleWebviewController alloc] init];
    XBUINavigationController * rootnc1 = [[XBUINavigationController alloc]initWithRootViewController:firstVC];
    [firstVC release];
    
    MultiWebViewController* sencdVC = [[MultiWebViewController alloc]init];
    XBUINavigationController * rootnc2 = [[XBUINavigationController alloc]initWithRootViewController:sencdVC];
    [sencdVC release];
    
    VideoPlayerViewController * thirdVC = [[VideoPlayerViewController alloc]init];
    XBUINavigationController *rootc3 = [[XBUINavigationController alloc]initWithRootViewController:thirdVC];
    [thirdVC release];
    
    CommonViewController* forthVC = [[CommonViewController alloc]init];
    XBUINavigationController *rootc4 = [[XBUINavigationController alloc]initWithRootViewController:forthVC];
    [forthVC release];
    
	NSArray *ctrlArr = [NSArray arrayWithObjects:rootnc1,rootnc2,rootc3,rootc4,nil];
	[rootnc1 release];
    [rootnc2 release];
	[rootc3 release];
    [rootc4 release];
    
	NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic1 setObject:PNGImage1x(@"tab_discovery_n") forKey:@"Default"];
	[imgDic1 setObject:PNGImage1x(@"tab_discovery_h") forKey:@"Highlighted"];
	[imgDic1 setObject:PNGImage1x(@"tab_discovery_h") forKey:@"Seleted"];
	NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic2 setObject:PNGImage1x(@"tab_me_n") forKey:@"Default"];
	[imgDic2 setObject:PNGImage1x(@"tab_me_h")  forKey:@"Highlighted"];
	[imgDic2 setObject:PNGImage1x(@"tab_me_h")  forKey:@"Seleted"];
	NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic3 setObject:PNGImage1x(@"tab_more_n") forKey:@"Default"];
	[imgDic3 setObject:PNGImage1x(@"tab_more_h") forKey:@"Highlighted"];
	[imgDic3 setObject:PNGImage1x(@"tab_more_h") forKey:@"Seleted"];
	NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
	[imgDic4 setObject:PNGImage1x(@"tab_search_n") forKey:@"Default"];
	[imgDic4 setObject:PNGImage1x(@"tab_search_h") forKey:@"Highlighted"];
	[imgDic4 setObject:PNGImage1x(@"tab_search_h") forKey:@"Seleted"];
		
	NSArray *imgArr = [NSArray arrayWithObjects:imgDic1,imgDic2,imgDic3,imgDic4,nil];
	
	self.tabBarController = [[XBTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
	[self.tabBarController.tabBar setBackgroundImage:PNGImage(@"navigationbar_bg_translucent")];
	[self.tabBarController setTabBarTransparent:NO];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	[self.window addSubview:tabBarController.view];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
