//
//  XBNavigationController.h
//  XB
//
//  Created by luoxubin on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTabBarController.h"
@interface XBNavigationController : UIViewController{
    UIImageView *navShadow;
    BOOL isShowing;
    UILabel *titleLabel;
}

- (NSString *)defaultBackTitle;
- (void)setBackTitle:(NSString *)backTitle;
- (void)addSubview:(UIView *)subview;
+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)aTitle andAction:(SEL)action inDelegate:(id)delegate;
+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)aTitle andAction:(SEL)action inDelegate:(id)delegate enable:(BOOL)aEnable;
- (void)back:(id)sender;
@end



@interface UINavigationBar(CustomBackground)

@end


