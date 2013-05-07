//
//  VideoPlayerViewController.h
//  XB
//
//  Created by luoxubin on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBNavigationController.h"
#import "M3U8Handler.h"
#import "VideoDownloader.h"


@interface VideoPlayerViewController : XBNavigationController<UIWebViewDelegate,M3U8HandlerDelegate,VideoDownloadDelegate>
{
    UIWebView* m_webView;
    
    UIButton* m_btnStartDownload;
    UIButton* m_btnStopDownload;
    UIButton* m_btnPlay;
    
    VideoDownloader* m_downloader;
     M3U8Handler* m_handler; 
    
    NSString* m_urlM3U8;
}


@end
