//
//  CommonViewController.h
//  DomobExampleForiPhone
//
//  Created by Shunfeng on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoMobDelegateProtocol.h"

@class DoMobView;
@interface CommonViewController : UIViewController <DoMobDelegate> {
	DoMobView *domobView;	
}

@property (retain,nonatomic) DoMobView *domobView;	
@end
