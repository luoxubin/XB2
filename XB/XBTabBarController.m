//
//  XBTabBarController.m
//  XBTabBarController
//
//  Created by luoxubin on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "XBTabBarController.h"
#import "XBTabBar.h"
#define kTabBarHeight 44.0f

static XBTabBarController *xbTabBarController;

@implementation UIViewController (XBTabBarControllerSupport)

- (XBTabBarController *)xbTabBarController
{
	return xbTabBarController;
}

@end

@interface XBTabBarController (private)
- (void)displayViewAtIndex:(NSUInteger)index;
@end

@implementation XBTabBarController
@synthesize delegate = _delegate;
@synthesize selectedViewController = _selectedViewController;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarHidden = _tabBarHidden;

#pragma mark -
#pragma mark lifecycle
- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr;
{
	self = [super init];
	if (self != nil)
	{
		_viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
		
		_containerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
		
		_transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight)];
		_transitionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
		
		_tabBar = [[XBTabBar alloc] initWithFrame:CGRectMake(0, _containerView.frame.size.height - kTabBarHeight, 320.0f, kTabBarHeight) buttonImages:arr];
		_tabBar.delegate = self;
		
        xbTabBarController = self;
        self.selectedIndex = 0;
	}
	return self;
}

- (void)loadView 
{
	[super loadView];
	[_containerView addSubview:_transitionView];
	[_containerView addSubview:_tabBar];
	self.view = _containerView;
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
}
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	_tabBar = nil;
	_viewControllers = nil;
}


- (void)dealloc 
{
    _tabBar.delegate = nil;
	[_tabBar release];
    [_containerView release];
    [_transitionView release];
	[_viewControllers release];
    [super dealloc];
}

#pragma mark - instant methods

- (XBTabBar *)tabBar
{
	return _tabBar;
}
- (BOOL)tabBarTransparent
{
	return _tabBarTransparent;
}
- (void)setTabBarTransparent:(BOOL)yesOrNo
{
	if (yesOrNo == YES)
	{
		_transitionView.frame = _containerView.bounds;
	}
	else
	{
		_transitionView.frame = CGRectMake(0, 0, 320.0f, _containerView.frame.size.height - kTabBarHeight);
	}
    
}
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;
{
	if (yesOrNO == YES)
	{
		if (self.tabBar.frame.origin.y == self.view.height)
		{
			return;
		}
	}
	else 
	{
		if (self.tabBar.frame.origin.y == self.view.height - kTabBarHeight)
		{
			return;
		}
	}
	
	if (animated == YES)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.25f];
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(0, _containerView.height, self.tabBar.width, self.tabBar.height);
            _transitionView.height = _containerView.height;
		}
		else 
		{
			self.tabBar.frame = CGRectMake(0, _containerView.height - kTabBarHeight, self.tabBar.width, self.tabBar.height);
            _transitionView.height = _containerView.height - kTabBarHeight;
		}
		[UIView commitAnimations];
	}
	else 
	{
		if (yesOrNO == YES)
		{
			self.tabBar.frame = CGRectMake(0, _containerView.height, self.tabBar.width, self.tabBar.height);
            _transitionView.height = _containerView.height;
		}
		else 
		{
			self.tabBar.frame = CGRectMake(0, _containerView.height - kTabBarHeight, self.tabBar.width, self.tabBar.height);
            _transitionView.height = _containerView.height - kTabBarHeight;
		}
	}
}




- (NSUInteger)selectedIndex
{
	return _selectedIndex;
}
- (UIViewController *)selectedViewController
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)index
{
    [self displayViewAtIndex:index];
    [_tabBar selectTabAtIndex:index];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    // Remove view from superview.
    [[(UIViewController *)[_viewControllers objectAtIndex:index] view] removeFromSuperview];
    // Remove viewcontroller in array.
    [_viewControllers removeObjectAtIndex:index];
    // Remove tab from tabbar.
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


#pragma mark - Private methods
- (void)displayViewAtIndex:(NSUInteger)index
{
    // Before change index, ask the delegate should change the index.
    if ([_delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) 
    {
        if (![_delegate tabBarController:self shouldSelectViewController:[self.viewControllers objectAtIndex:index]])
        {
            return;
        }
    }
    // If target index if equal to current index, do nothing.
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0) 
    {
        return;
    }
    DLog(@"Display View.");
    _selectedIndex = index;
    
	UIViewController *selectedVC = [self.viewControllers objectAtIndex:index];
	
	selectedVC.view.frame = _transitionView.frame;
	if ([selectedVC.view isDescendantOfView:_transitionView]) 
	{
		[_transitionView bringSubviewToFront:selectedVC.view];
	}
	else
	{
		[_transitionView addSubview:selectedVC.view];
	}
    
    // Notify the delegate, the viewcontroller has been changed.
    if ([_delegate respondsToSelector:@selector(tabBarController:didSelectViewController::)]) 
    {
        [_delegate tabBarController:self didSelectViewController:selectedVC];
    }
    
}

#pragma mark -
#pragma mark tabBar delegates
- (void)tabBar:(XBTabBar *)tabBar didSelectIndex:(NSInteger)index
{
	[self displayViewAtIndex:index];
}
@end


@implementation XBUINavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.visibleViewController.hidesBottomBarWhenPushed != YES) {
        if (viewController.hidesBottomBarWhenPushed == YES) {
            [self.visibleViewController.xbTabBarController hidesTabBar:YES animated:animated];
        }
    }
	[super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	//the vc that will be poped to be visible to user
	UIViewController* vcWillBeVisible = nil;
	int count = [self.viewControllers count];
	if (count >= 2) {
		vcWillBeVisible = [self.viewControllers objectAtIndex:count -2];
	}
	
	if(vcWillBeVisible){
        //当前hiden是唯一的yes
        // pop 返回的规则,当前hiden为yes, 前一个为no, 则显示
        if (self.visibleViewController.hidesBottomBarWhenPushed == YES && vcWillBeVisible.hidesBottomBarWhenPushed == NO) {
            int currentIndex = [self.viewControllers indexOfObject:self.visibleViewController];
            BOOL isTheOnlyHiden = YES;
            for (int i = 0; i< currentIndex; i++) {
                UIViewController* vc = [self.viewControllers objectAtIndex:i];
                if (vc.hidesBottomBarWhenPushed) {
                    isTheOnlyHiden = NO;
                    break;
                }
            }
            if (isTheOnlyHiden) {
                [self.visibleViewController.xbTabBarController hidesTabBar:NO animated:animated];
            }
        }
	}
	
	return [super popViewControllerAnimated:animated];	
}

@end