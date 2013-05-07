//
//  XBNavigationController.m
//  XB
//
//  Created by luoxubin on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XBNavigationController.h"
#import "XBTabBarController.h"
#import "UIViewAdditions.h"
#import "Utility.h"

#define ButtonTitleSize 13
//#define ButtonTitleColor [UIColor colorWithRed:0.620 green:0 blue:0.118 alpha:1]
#define ButtonTitleColor [UIColor whiteColor]

@implementation XBNavigationController

- (void)loadView
{
	[super loadView];
	self.view.backgroundColor = ColorBG;
    
	//给navigationBar添加背景图
	if ([Utility iOS5Simida]) {
		[self.navigationController.navigationBar setBackgroundImage:PNGImage(@"navigationbar_bg")
													  forBarMetrics:UIBarMetricsDefault];
	}
	
	// 导航按钮
	NSArray *controllers = [self.navigationController viewControllers];
	if ([controllers count] > 1) {
		[self setBackTitle:[self defaultBackTitle]];
	}
	
	// 导航栏下方阴影
	if (!navShadow) {
		navShadow = [[UIImageView alloc] initWithImage:PNGImage(@"navigationbar_shadow")];
		navShadow.frame = CGRectMake(0, 0, 320, 5);
	}
	[self.view addSubview:navShadow];
}


- (void)viewDidAppear:(BOOL)animated {
	isShowing = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	isShowing = NO;
}

- (NSString *)defaultBackTitle {
	NSArray *controllers = [self.navigationController viewControllers];
	if ([controllers count] > 1) {
		UIViewController *controller = [[self.navigationController viewControllers] objectAtIndex:[controllers count] - 2];
		if (controller.title) {
			return controller.title;
		}
	}
	return @"返回";
}

- (void)back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setBackTitle:(NSString *)backTitle {
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 42.5, 29)];
    
    UIImage *img0 = [PNGImage(@"button_navigation_back_0") stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    UIImage *img1 = [PNGImage(@"button_navigation_back_1") stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [backButton setBackgroundImage:img0 forState:UIControlStateNormal];
    [backButton setBackgroundImage:img1 forState:UIControlStateHighlighted];
    UIImageView *iv_arrow = [[UIImageView alloc] initWithImage:PNGImage(@"button_navigation_arrow")];
    iv_arrow.frame = CGRectMake(10, 5, 25, 18);
    iv_arrow.userInteractionEnabled = NO;
    [backButton addSubview:iv_arrow];
    
	[backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	self.navigationItem.leftBarButtonItem = backButtonItem;
	self.navigationItem.backBarButtonItem = nil;
	[backButtonItem release];
}

- (void)addSubview:(UIView *)subview {
	[self.view addSubview:subview];
	[self.view bringSubviewToFront:navShadow];
}

+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)aTitle andAction:(SEL)action inDelegate:(id)delegate {
    return  [self buttonItemWithTitle:aTitle andAction:action inDelegate:delegate enable:YES];
}

+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)aTitle andAction:(SEL)action inDelegate:(id)delegate enable:(BOOL)aEnable {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];	
    [button setFrame:CGRectMake(0, 0, 51, 29)];
	if (aTitle) {
		button.width = [aTitle sizeWithFont:FontWithSize(ButtonTitleSize)].width + 20;//([aTitle length] - 2) * 10;
	}
    UIImage *img0 = [PNGImage(@"button_navigation_normal_0") stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    UIImage *img1 = [PNGImage(@"button_navigation_normal_1") stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [button setBackgroundImage:img0 forState:UIControlStateNormal];
    [button setBackgroundImage:img1 forState:UIControlStateHighlighted];
	button.titleLabel.font = FontWithSize(ButtonTitleSize);
    [button setTitleColor:aEnable?ButtonTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[button setTitle:aTitle forState:UIControlStateNormal];
	[button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    buttonItem.customView.backgroundColor = [UIColor clearColor];
    buttonItem.enabled = aEnable;
	return [buttonItem autorelease];
}

- (void)dealloc {
	[navShadow release];
    [titleLabel release];
	[super dealloc];
}

- (void)setTitle:(NSString *)title
{
    CGSize size = [title sizeWithFont:FontWithSize(18) constrainedToSize:CGSizeMake(250, MAXFLOAT) lineBreakMode:UILineBreakModeTailTruncation];
    CGRect frame = CGRectMake(0, 0, size.width, 44);
    titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = FontWithSize(18);
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

@end


@implementation UINavigationBar(CustomBackground)

- (void)drawRect:(CGRect)rect {
	if ([Utility iOS5Simida]) {
		[super drawRect:rect];
	} else {
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGContextSaveGState(ctx);
		if (self.tag == 0) {
			[PNGImage(@"navigationbar_bg") drawAsPatternInRect:rect];;
		} else {
			[PNGImage(@"navigationbar_bg_translucent") drawAsPatternInRect:rect];
		}
		CGContextRestoreGState(ctx);
	}
}

@end


