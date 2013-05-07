//
//  MultiWebViewController.h
//  XB
//
//  Created by luoxubin on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBNavigationController.h"
@interface MultiWebViewController : XBNavigationController<UIWebViewDelegate,UITableViewDelegate, UITableViewDataSource>
{
    UITableView* tableView;
}

@end
