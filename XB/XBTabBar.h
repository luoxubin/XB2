//
//  XBTabBar.h
//  XB
//
//  Created by luoxubin on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XBTabBarDelegate;

@interface XBTabBar : UIView
{
	UIImageView *_backgroundView;
	id<XBTabBarDelegate> _delegate;
	NSMutableArray *_buttons;
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, assign) id<XBTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;


- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;
@end
@protocol XBTabBarDelegate<NSObject>
@optional
- (void)tabBar:(XBTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
