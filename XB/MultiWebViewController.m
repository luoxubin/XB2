//
//  MultiWebViewController.m
//  XB
//
//  Created by luoxubin on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiWebViewController.h"
@implementation MultiWebViewController

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

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.title = @"multiwebview test";
    self.view.backgroundColor = [UIColor brownColor];
    
    if (!tableView) {
		tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 416) 
                                                 style:UITableViewStylePlain];	
		tableView.backgroundColor = [UIColor clearColor];
		tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		tableView.separatorColor = ColorRedGreenBlue(223, 217, 207);
		tableView.delegate = self;
		tableView.dataSource = self;
	}
	[self addSubview:tableView];
    
    
    UIButton* btn_reset = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_reset.frame = CGRectMake(0, 100, 60, 30);
    [btn_reset setTitle:@"refesh" forState:UIControlStateNormal];
    btn_reset.showsTouchWhenHighlighted=YES;
    [btn_reset addTarget:self action:@selector(refeshTableView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn_reset];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [rightButtonItem release];

    
}

-(void)refeshTableView
{
    if(tableView)
    {
        [tableView reloadData];
    }
}
 

-(void)dealloc
{
    SafeRelease(tableView);
    [super dealloc];
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

#pragma mark -
#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)table
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    NSString* CellIdentifier1 = [NSString stringWithFormat:@"www.baidu.com"];
    NSString* CellIdentifier2 = [NSString stringWithFormat:@"www.qq.com"];
    int row = indexPath.row;
    UITableViewCell *cell = nil;
    if(row %2 == 0)
    {
        cell = [table dequeueReusableCellWithIdentifier:CellIdentifier1];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1]autorelease];
            UIWebView* webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
            webview.tag = 111;
            webview.delegate = self;
            [cell.contentView addSubview:webview];
            [webview release];
        }
        [(UIWebView*)[cell viewWithTag:111] loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.baidu.com"]]]];
    }
    else
    {
        cell = [table dequeueReusableCellWithIdentifier:CellIdentifier2];
        if(cell == nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2]autorelease];
            UIWebView* webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
            webview.tag = 222;
            webview.delegate = self;
            [cell.contentView addSubview:webview];
            [webview release];
        }
        [(UIWebView*)[cell viewWithTag:222] loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.qq.com"]]]];
    }
    return cell;
}

@end
