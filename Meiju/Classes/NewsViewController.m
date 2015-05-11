//
//  NewsNavigateController.m
//  Meiju
//
//  Created by brustar on 12-4-17.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

@implementation NewsViewController
@synthesize details,items,arrNews;

-(NSMutableArray *)fetchNewsArrayFromJSON:(NSString *)data
{	
	NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];
		if(dic)
		{
			//initWithFormat是为了容错CFNumber，即json中有不带引号的value
			NSString *newsId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"newsId"]];
			News *news=[[News alloc] init];
			news.newsId=newsId;
			news.picAddr=[dic objectForKey:PIC_KEY];
			news.title=[dic objectForKey:@"title"];
			news.content=[dic objectForKey:@"content"];
			[retArray addObject:news];
			[news release];
		}
	}
	return [retArray autorelease];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	[super viewDidLoad];
	self.title=@"快讯";
    self.navigationController.navigationBar.tintColor=ORANGE_BG;
	//self.view.backgroundColor = SYS_BG;
	//建立连接，取数据
    receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:NEWSURL];
	[DataSource createConn:url delegate:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//点击cell more
	if (indexPath.row == start+PAGE_LENGTH) { 
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"loading more …"; 
        [self performSelectorInBackground:@selector(loadMore) withObject:nil]; 
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return; 
    }
	//其他cell的事件 
	details = [[NewsDetailViewController alloc] init];
	details.news=[self.arrNews objectAtIndex:indexPath.row];
    details.title=@"快讯详情";
	//[self presentModalViewController:details animated:TRUE];
	[[self navigationController] pushViewController:details animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int count = [items count]; 
    if (count<start+PAGE_LENGTH) //不足一页时
    { 
		return count;
	}
    return  count + 1; 
}

-(void)loadMore 
{ 
    NSMutableArray *more; 
    more=[[NSMutableArray alloc] initWithCapacity:0];
	
	start+=PAGE_LENGTH;
    for (int i=start; i<start+PAGE_LENGTH; i++) { 
		if(i<[arrNews count])
		{
			[more addObject:[arrNews objectAtIndex:i]]; 
		}
    } 
    //加载你的数据 
    [self performSelectorOnMainThread:@selector(appendTableWith:) withObject:more waitUntilDone:NO]; 
	
    [more release]; 
}

-(void) appendTableWith:(NSMutableArray *)data 
{ 
    NSArray *arr=[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:[items count] inSection:0], nil];
    //先删除更多，后面再追加
    [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    for (int i=0;i<[data count];i++) { 
        [items addObject:[data objectAtIndex:i]]; 
    } 
	
    NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:10]; 
    for (int ind = 0; ind < [data count]; ind++) { 
        NSIndexPath *newPath =  [NSIndexPath indexPathForRow:[items indexOfObject:[data objectAtIndex:ind]] inSection:0]; 
        [insertIndexPaths addObject:newPath]; 
    }

	[self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];     
} 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *tag=@"Cell"; 
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag]; 
    if (cell==nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tag] autorelease];
    } 
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if ([indexPath row]<[arrNews count]) {		
		if([indexPath row] == [items count]) { 
			//创建loadMoreCell 
			cell.textLabel.text=MORE; 
			cell.detailTextLabel.text=@"";
		}else {
			News *news=[items objectAtIndex:[indexPath row]];
			cell.textLabel.text=news.title;
			cell.textLabel.textAlignment= UITextAlignmentLeft;
			cell.detailTextLabel.numberOfLines=1;
			NSString *detail=news.content;
			cell.detailTextLabel.text=detail;
		} 
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell; 
}

//下拉更多
-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{	
	if(scrollView.contentOffset.y>scrollView.contentSize.height-scrollView.frame.size.height+20)
	{
		if ([arrNews count]>start+PAGE_LENGTH) { //存在第二页时
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:[arrNews count] inSection:0];
            UITableViewCell *loadMoreCell=[self.tableView cellForRowAtIndexPath:indexPath]; 
            loadMoreCell.textLabel.text=@"loading more …"; 
            loadMoreCell.selected=YES;
            [self performSelectorInBackground:@selector(loadMore) withObject:nil]; 
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
		}
	}
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[arrNews release];
	[details release];
    [items release];
    [super dealloc];
}

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[NSString alloc] 
			initWithBytes:[receivedData bytes] 
			length:[receivedData length] 
			encoding:NSUTF8StringEncoding];
	
	self.arrNews=[self fetchNewsArrayFromJSON:json];
	start=0;
	
	items=[[NSMutableArray alloc] initWithCapacity:0]; 
    for (int i=0; i<PAGE_LENGTH; i++) {
		if (i<[arrNews count]) {
			[items addObject:[arrNews objectAtIndex:i]]; 
		}
    }
	[self.tableView reloadData];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
