//
//  VideoPlayerViewController.m
//  XB
//
//  Created by luoxubin on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "M3U8Handler.h"
@interface VideoPlayerViewController ()



@end

@implementation VideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    m_webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 120, 320, 340)];
    m_webView.delegate = self;
    m_webView.scalesPageToFit = YES;
    
    m_btnStartDownload  = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
    m_btnStartDownload.backgroundColor = [UIColor redColor];
    [m_btnStartDownload setTitle:@"开始下载" forState:UIControlStateNormal];
    m_btnStartDownload.showsTouchWhenHighlighted = YES;
    
    
    m_btnStopDownload = [[UIButton alloc]initWithFrame:CGRectMake(150, 20, 100, 30)];
    m_btnStopDownload.backgroundColor = [UIColor redColor];
    [m_btnStopDownload setTitle:@"暂停下载" forState:UIControlStateNormal];
    m_btnStopDownload.showsTouchWhenHighlighted = YES;
    
    
    
    m_btnPlay = [[UIButton alloc]initWithFrame:CGRectMake(50, 70, 200, 40)];
    m_btnPlay.backgroundColor = [UIColor redColor];
    [m_btnPlay setTitle:@"本地视频播放" forState:UIControlStateNormal];
    m_btnPlay.showsTouchWhenHighlighted = YES;
    
    [self.view addSubview:m_webView];
    [self.view addSubview:m_btnPlay];
    [self.view addSubview:m_btnStartDownload];
    [self.view addSubview:m_btnStopDownload];
    
    NSURL * url = [[NSURL alloc]initWithString:@"http://v.youku.com/v_show/id_XNDczNjExNTAw.html"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [url release];
    [m_webView loadRequest:request];
    [request release];
    
    
    
    m_handler =  [[M3U8Handler alloc]init];
    m_handler.delegate = self;

     
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



-(void)dealloc
{
    [m_webView release];
    [m_btnPlay release];
    [m_btnStartDownload release];
    [m_btnStopDownload release];
    [m_urlM3U8 release];
    [super dealloc];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Waiting view is useless, remove it.

    // NSString *lJs = @"document.documentElement.innerHTML";
    // NSString *lJs2 = @"(document.getElementsByTagName(\"video\")[0]).getElementsByTagName(\"source\")[0].src";  //qiyi
    
    NSString *lJs2 = @"(document.getElementsByTagName(\"video\")[0]).src";  // youku,tudou,ku6 ,souhu
    //    
    NSString * m3u8_url = [webView stringByEvaluatingJavaScriptFromString:lJs2];
    //   NSLog(@"htmlabc:%@",lHtml1);
         NSLog(@"video source:%@",m3u8_url);
    
    if([m3u8_url hasSuffix:@".m3u8"])
    {        
        m_webView.delegate = nil;
        [m_handler praseUrl:m3u8_url];
        
    }
    
}


-(void)praseM3U8Finished:(M3U8Handler*)handler
{
    m_btnStartDownload.backgroundColor = [UIColor greenColor];
    handler.playlist.uuid = @"moive1";
    m_downloader = [[VideoDownloader alloc]initWithM3U8List:handler.playlist];
    m_downloader.delegate = self;
    [m_btnStartDownload addTarget:self action:@selector(OnClickStartDownload) forControlEvents:UIControlEventTouchUpInside];
    [m_btnStopDownload addTarget:self action:@selector(OnClickStopDownload) forControlEvents:UIControlEventTouchUpInside];
    [m_btnPlay addTarget:self action:@selector(OnclickPlay) forControlEvents:UIControlEventTouchUpInside];
}



-(void)praseM3U8Failed:(M3U8Handler*)handler
{
    NSLog(@"praseM3U8Failed");
}


-(void)OnClickStartDownload
{
    if(m_downloader )
    {
        [m_downloader startDownloadVideo];
    }
}

-(void)OnClickStopDownload
{
    if(m_downloader)
    {
        [m_downloader stopDownloadVideo];
    }
}

-(void)videoDownloaderFinished:(VideoDownloader*)request
{
    m_btnPlay.backgroundColor = [UIColor greenColor];
    
    
    m_urlM3U8 = [[request createLocalM3U8file]retain];
}

-(void)OnclickPlay
{
   [ m_webView loadRequest:[[NSURLRequest alloc]initWithURL:[[NSURL alloc]initWithString:@"http://127.0.0.1:12345/moive1/movie.m3u8"]]];
}

@end
