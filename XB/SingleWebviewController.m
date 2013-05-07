//
//  SingleWebviewController.m
//  XB
//
//  Created by luoxubin on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleWebviewController.h"
#import "XBNavigationController.h"
#import "MultiWebViewController.h"

@implementation SingleWebviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)loadbaidu
{
    NSString *url = [NSString stringWithFormat:@"http://v.youku.com/v_playlist/f17025968o1p0.html"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webview2 loadRequest:request];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"myfirstios" ofType:@"html"];
//    [webview2 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
   
}

-(void)loadQQ
{
    NSString *url = [NSString stringWithFormat:@"http://127.0.0.1:12345/index.html"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webview3 loadRequest:request];
    
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"myfirstios" ofType:@"html"];
//    [webview3 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
//    

}
#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.title = @"webview interact";
    webview1 = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
    webview1.backgroundColor = [UIColor yellowColor];
    webview1.delegate = self;

    
    webview2 = [[UIWebView alloc]initWithFrame:CGRectMake(0, 185, 150, 230)];
    webview2.backgroundColor = [UIColor greenColor];
    webview2.delegate = self;
    
    
    webview3 = [[UIWebView alloc]initWithFrame:CGRectMake(160, 185, 150, 230)];
    webview3.backgroundColor = [UIColor greenColor];
    webview3.delegate = self;
    
    
    [self addSubview:webview1];
    [self addSubview:webview2];
    [self addSubview:webview3];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"htmltest" ofType:@"html"];
    [webview1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    
    
    
//   // NSString *url = [NSString stringWithFormat:@"http://fe.baidu.com/~heliang/client/shenbian/android/"];
//    NSString *url = [NSString stringWithFormat:@"http://waps.baidu.com/3rd_party/?act=zhuanti&file_name=paike_topic"];
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    [webview1 loadRequest:request];
    
    
    
    UIButton* btn_reset = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_reset.frame = CGRectMake(0, 100, 60, 30);
    [btn_reset setTitle:@"reset" forState:UIControlStateNormal];
    btn_reset.showsTouchWhenHighlighted = YES;
    [btn_reset addTarget:self action:@selector(resetWebView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_reset];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [rightButtonItem release];
}



-(void)resetWebView
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    webview1.frame = CGRectMake(0, 0, 320, 180);
    webview2.frame = CGRectMake(0, 185, 150, 230);
    webview3.frame = CGRectMake(160, 185, 150, 230);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"htmltest" ofType:@"html"];
    [webview1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    
    [webview2 loadHTMLString:@" " baseURL:nil];
    [webview3 loadHTMLString:@" " baseURL:nil];
	[UIView commitAnimations];
}




-(void)hideWedview1
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    webview1.frame = CGRectMake(0, 0, 0, 0);
    webview2.frame = CGRectMake(0, 0, 150, 416);
    webview3.frame = CGRectMake(160, 0, 150, 416);
   	[UIView commitAnimations];
    
}


-(void)domove
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(webview3.origin.x >320)
    {
        webview2.width = 150;
        webview3.left =160;
    }
    else
    {
        webview2.width = 320;
        webview3.left = 321;
    }
	[UIView commitAnimations];
    
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)dealloc
{
    [webview1 release];
    [webview2 release];
    [webview3 release];
    [super dealloc];
}

#pragma mark - WebView

- (BOOL)webView:(UIWebView *)webView 
shouldStartLoadWithRequest:(NSURLRequest *)request 
 navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"baidu"]) {
		//	符合身边协议的链接
		NSString *action = [url host];  
        
        if([action isEqualToString:@"loadbaidu"])
        {
            [self loadbaidu];
            return NO;
        }
        if([action isEqualToString:@"loadqq"])
        {
            [self loadQQ];
            return NO;
        }
        if([action isEqualToString:@"hideWebview"])
        {
            [self hideWedview1];
            return NO;
        }
        if( [action isEqualToString:@"domove"])
        {
            [self domove];
            return  NO;
        }
        
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)_webView {
    
    NSLog(@"start ");
    
}



- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    
    NSLog(@"finish");
    
  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  }

@end
