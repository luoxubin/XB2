//
//  XBTabBarController.h
//  XB
//
//  Created by luoxubin on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBTabBar.h"
#import "WebVideoUIView.h"
@class UITabBarController;
@protocol XBTabBarControllerDelegate;
@interface XBTabBarController : UIViewController <XBTabBarDelegate>
{
	XBTabBar *_tabBar;
	UIView      *_containerView;
	UIView		*_transitionView;
	id<XBTabBarControllerDelegate> _delegate;
	NSMutableArray *_viewControllers;
	NSUInteger _selectedIndex;
	
	BOOL _tabBarTransparent;
	BOOL _tabBarHidden;
}

@property(nonatomic, copy) NSMutableArray *viewControllers;

@property(nonatomic, readonly) UIViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

// Apple is readonly
@property (nonatomic, readonly) XBTabBar *tabBar;
@property(nonatomic,assign) id<XBTabBarControllerDelegate> delegate;


// Default is NO, if set to YES, content will under tabbar
@property (nonatomic) BOOL tabBarTransparent;
@property (nonatomic) BOOL tabBarHidden;

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;

- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

// Remove the viewcontroller at index of viewControllers.
- (void)removeViewControllerAtIndex:(NSUInteger)index;

// Insert an viewcontroller at index of viewControllers.
- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;

@end


@protocol XBTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(XBTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(XBTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

@interface UIViewController (XBTabBarControllerSupport)
@property(nonatomic, readonly) XBTabBarController *xbTabBarController;
@end

//自定义controller压栈或者弹栈时Tabbar的隐藏
@interface XBUINavigationController:UINavigationController<UINavigationControllerDelegate>

@end
