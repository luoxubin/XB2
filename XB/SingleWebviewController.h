//
//  SingleWebviewController.h
//  XB
//
//  Created by luoxubin on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBNavigationController.h"
@interface SingleWebviewController:XBNavigationController<UIWebViewDelegate>
{
    UIWebView* webview1;
    UIWebView* webview2;
    UIWebView* webview3;
}

@end
