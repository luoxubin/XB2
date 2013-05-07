    //
//  CommonViewController.m
//  DomobExampleForiPhone
//
//  Created by Shunfeng on 11/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CommonViewController.h"
#import "DoMobView.h"
#define TestUserSpot @"all"
@implementation CommonViewController
@synthesize domobView; 

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor yellowColor];
	self.domobView = [DoMobView requestDoMobViewWithSize:CGSizeMake(320, 48) WithDelegate:self];
	[super viewDidLoad];
}


#pragma mark -
#pragma mark DoMobDelegate methods
- (UIViewController *)domobCurrentRootViewControllerForAd:(DoMobView *)doMobView
{
	return self;
}

- (NSString *)domobPublisherIdForAd:(DoMobView *)doMobView
{
	// 请到www.domob.cn网站注册获取自己的publisher id
	return @"56OJyJgouM8Pji1D6x";
}

// 发布前请取消下面函数的注释

/*
 - (NSString *)domobKeywords
 {
 return @"iPhone,game";
 }*/
/*
 - (NSString *)domobPostalCode
 {
 return @"100032";
 }
 
 - (NSString *)domobDateOfBirth
 {
 return @"20101211";
 }
 
 - (NSString *)domobGender
 {
 return @"male";
 }
 
 - (double)domobLocationLongitude
 {
 return 391.0;
 }
 
 - (double)domobLocationLatitude
 {
 return -200.1;
 }
 */
- (NSString *)domobSpot:(DoMobView *)doMobView;
{
	return TestUserSpot;
}
// Sent when an ad request loaded an ad; 
// it only send once per DoMobView
- (void)domobDidReceiveAdRequest:(DoMobView *)doMobView
{
	self.domobView.frame = CGRectMake(0, self.view.frame.size.height - self.domobView.frame.size.height, self.domobView.frame.size.width, self.domobView.frame.size.height);
	[self.view addSubview:self.domobView];
}

- (void)domobDidFailToReceiveAdRequest:(DoMobView *)doMobView
{
}
/*
 - (UIColor *)adBackgroundColorForAd:(DoMobView *)doMobView
 {
 return [UIColor blackColor];
 }*/

- (void)domobWillPresentFullScreenModalFromAd:(DoMobView *)doMobView
{
	NSLog(@"The view will Full Screen");
}

- (void)domobDidPresentFullScreenModalFromAd:(DoMobView *)doMobView
{
	NSLog(@"The view did Full Screen");
}

- (void)domobWillDismissFullScreenModalFromAd:(DoMobView *)doMobView
{
	NSLog(@"The view will Dismiss Full Screen");
}

- (void)domobDidDismissFullScreenModalFromAd:(DoMobView *)doMobView
{
	NSLog(@"The view did Dismiss Full Screen");
}

-(DomobADTransitionType)domobTransitionType:(DoMobView *)doMobView
{
    return  DomobADTransitionFragment;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
	[textField resignFirstResponder];
	return YES;
}

- (void)dealloc {
	self.domobView.doMobDelegate = nil;
	self.domobView = nil;
    [super dealloc];
}

@end
