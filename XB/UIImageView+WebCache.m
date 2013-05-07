/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageView (WebCache)

- (void)_showLoadingImageIndicator
{
	UIActivityIndicatorView *loadingIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	loadingIndicator.hidesWhenStopped = YES;
    loadingIndicator.center = self.center;
    [loadingIndicator startAnimating];
    [self addSubview:loadingIndicator];
}

- (void)_hidenLoadingImageIndicator
{
	for (UIView *subview in [self subviews]) {
		if ([subview isKindOfClass:[UIActivityIndicatorView class]]) {
			[subview removeFromSuperview];
		}
	}
}

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	[self _showLoadingImageIndicator];
	
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
	[self _hidenLoadingImageIndicator];
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
	[self _hidenLoadingImageIndicator];
	CATransition *transition = [CATransition animation];
    transition.duration = 0.7f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:nil];
}

@end
