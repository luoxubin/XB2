//
//  WebVideoUIView.m
//  BaiduVideo
//
//  Created by luoxubin on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebVideoUIView.h"

@implementation WebVideoUIView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)didAddSubview:(UIView *)subview
{
    NSLog(@"didAddSubview");
    if(subview.tag == 0)
    {
        NSLog(@"add movie view");
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    if(subview.tag == 0)
    {
        NSLog(@"remove movie view");
    }
    
}

@end
