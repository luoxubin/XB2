//
//  AppDelegate.h
//  XB
//
//  Created by luoxubin on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTabBarController.h"

@class HTTPServer;


@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
    HTTPServer* httpServer;
    UIWindow *window;
    XBTabBarController* tabBarController;
}

@property (nonatomic,retain) UIWindow *window;
@property (nonatomic,retain)XBTabBarController* tabBarController;

@end
