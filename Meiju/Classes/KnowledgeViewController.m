//
//  KnowledgeViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KnowledgeViewController.h"

@interface KnowledgeViewController ()

@end

@implementation KnowledgeViewController

@synthesize cateConn,listConn,moreConn,knowledgeArray,pageNo,serverPages,param,details,categoryBox,filteConn;

#pragma mark HttpDelegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {	
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[UIMakerUtil alert:[error localizedDescription] title:@"Error"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *json = [[[NSString alloc] 
                       initWithBytes:[receivedData bytes] 
                       length:[receivedData length] 
                       encoding:NSUTF8StringEncoding] autorelease];
    if ([connection isEqual:self.listConn]) {
        self.knowledgeArray=[self fetchKnowledgeArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.moreConn]) {
        self.knowledgeArray=[self fetchKnowledgeArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.filteConn]) {
        self.knowledgeArray=[self fetchKnowledgeArrayFromJSON:json];
        self.serverPages=[[DataSource fetchJSONValueFormServer:json forKey:TOTALPAGE] intValue];
        [self.tableView reloadData];
    }else if ([connection isEqual:self.cateConn]) {
        NSArray *categoryBoxData = [self fetchClassificatoryFormJsonArray:json];
        ((PopUpBox*)self.categoryBox).popUpBoxDatasource = categoryBoxData;
        [((PopUpBox*)self.categoryBox) reloadData];
        [((PopUpBox*)self.categoryBox).alertView show];
    }
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(NSMutableArray *)fetchKnowledgeArrayFromJSON:(NSString *)data
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
			NSString *newsId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"sese_id"]];
			Knowledge *news=[[Knowledge alloc] init];
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

-(id)fetchClassificatoryFormJsonArray:(NSString *)data
{	
	NSDictionary *json= [DataSource fetchDictionaryFromURL:data];
	NSArray *array=[json objectForKey:JSONARRAY];
	
	NSMutableArray *retArray=[[NSMutableArray alloc] init];
	for(int i=0;i<[array count]; i++) 
	{
		NSDictionary *dic=[array objectAtIndex:i];

        //initWithFormat是为了容错CFNumber，即json中有不带引号的value
        NSString *typeId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"seseTypeCode"]];
        Classificatory *cate=[[[Classificatory alloc] init] autorelease];
        cate.typeId=typeId;
        cate.typeName=[dic objectForKey:@"seseTypeName"];
        [retArray addObject:cate];

	}
	return [retArray autorelease];
}

-(IBAction)selectCate:(id)sender
{
    self.categoryBox =[[[PopUpBox alloc] initWithFrame: CGRectMake(10, 7, 140, 30) withTitle:BOX_TITLE withButton:nil controller:self] autorelease];
    [self.view addSubview: self.categoryBox];
    
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:KNOWLEDGE_CATE_URL];
    self.cateConn=[DataSource createConn:url delegate:self];
}

-(void)searchClassificatory:(NSString *) typeId
{
   [((PopUpBox*)self.categoryBox).alertView dismissWithClickedButtonIndex: ((PopUpBox*)self.categoryBox).alertView.cancelButtonIndex animated: YES];
    
    NSString *p=[NSString stringWithFormat:@"pageNO=1&seseType=%@",typeId];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:KNOWLEDGE_URL withParam:p];
    self.filteConn=[DataSource createConn:url delegate:self];
}

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
    self.title=CAR_KNOWLEDGE;
    self.pageNo=1;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTint:ORANGE_BG andTitle:@"选择类别" andTarget:self andSelector:@selector(selectCate:)];
    
	// Do any additional setup after loading the view.
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *url=[ConstantUtil createRequestURL:KNOWLEDGE_URL withParam:@"pageNO=1"];
    self.listConn=[DataSource createConn:url delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    [super dealloc];
    [cateConn release];
    [listConn release];
    [moreConn release];
    [knowledgeArray release];
    [param release];
    [details release];
    [categoryBox release];
    [filteConn release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//点击cell more
	if (indexPath.row == [self.knowledgeArray count] && self.pageNo<self.serverPages) {
        UITableViewCell *loadMoreCell=[tableView cellForRowAtIndexPath:indexPath]; 
        loadMoreCell.textLabel.text=@"loading more …"; 
        [self performSelectorInBackground:@selector(loadMore) withObject:nil]; 
		[tableView deselectRowAtIndexPath:indexPath animated:YES]; 
        return; 
    }
	//其他cell的事件 
	details = [[NewsDetailViewController alloc] init];
	details.news=[self.knowledgeArray objectAtIndex:indexPath.row];
    details.title=@"常识详情";
	//[self presentModalViewController:details animated:TRUE];
	[[self navigationController] pushViewController:details animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int count = [self.knowledgeArray count]; 
	if (count<PAGE_LENGTH || self.pageNo==self.serverPages) { //不足一页时或者最后一页
		return count;
	}
    return  count + 1;
}

-(void) loadMore
{
	self.pageNo++;
    NSString *key;
	if (self.param) {
		key=[NSString stringWithFormat:@"pageNo=%d&%@",self.pageNo,self.param];//有param代表搜索后的分页
	}else {
		key=[NSString stringWithFormat:@"pageNo=%d",self.pageNo];  
	}
	
	receivedData=[[NSMutableData alloc] initWithData:nil];
	NSString *url=[ConstantUtil createRequestURL:KNOWLEDGE_URL withParam:key];
	self.moreConn=[DataSource createConn:url delegate:self];
} 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *tag=@"Cell"; 
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tag]; 
    if (cell==nil) { 
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tag] autorelease];
    } 
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if ([indexPath row]<[self.knowledgeArray count]) {		
		if (self.pageNo < self.serverPages) {
			//创建loadMoreCell 
			cell.textLabel.text=MORE; 
			cell.detailTextLabel.text=@"";
		}else {
			News *news=[self.knowledgeArray objectAtIndex:[indexPath row]];
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


@end
