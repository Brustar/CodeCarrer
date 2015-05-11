//
//  FavoritesViewController.m
//  Meiju
//
//  Created by Brustar XRL on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

@synthesize receivedData,favoritesArray,removeInfo,removeConn,listConn;

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
    if ([connection isEqual:listConn]) {
        self.favoritesArray=[self fetchFavoritesFormJson:json];
    }else if ([connection isEqual:self.removeConn]) {
        if ([[DataSource fetchValueFormJsonObject:json forKey:RETURN_CODE] isEqualToString:@"0"]) {
            [self.favoritesArray removeObject:self.removeInfo];
        }else {
            [UIMakerUtil alert:[DataSource fetchValueFormJsonObject:json forKey:RETURN_MESSAGE] title:self.title];
        }
    }
    
    [self.tableView reloadData];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(NSMutableArray *)fetchFavoritesFormJson:(NSString *)data
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
			NSString *goodsId=[NSString stringWithFormat:@"%@",[dic objectForKey:@"goodsId"]];
			NSString *mallPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"mallPrice"]];
			FavoriteInfo *info=[[[FavoriteInfo alloc] init] autorelease];	
            info.goodsId=goodsId;
            info.goodsName=[dic objectForKey:@"goodsName"];
            info.mallPrice=mallPrice;
            info.pubTime=[dic objectForKey:@"pubTime"];
            info.picAddr=[dic objectForKey:PIC_KEY];
            info.isNew=[dic objectForKey:@"isNew"];
            info.isPromot=[dic objectForKey:@"isPromot"];
            info.isBestSellers=[dic objectForKey:@"isBestSellers"];
            info.isRecommend=[dic objectForKey:@"isRecommend"];
            info.isPromot=[dic objectForKey:@"isPromot"];
            info.popularity=[dic objectForKey:@"popularity"];
			[retArray addObject:info];
		}
	}
	return [retArray autorelease];
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
	self.title=@"我的收藏";
    self.tableView.rowHeight=LINE_HEIGHT;
    
    UserInfo *info=[SessionUtil sharedInstance].userInformation;
    receivedData=[[NSMutableData alloc] initWithData:nil];
    NSString *param=[NSString stringWithFormat:@"&cusId=%@",info.cusId];
    NSString *url=[ConstantUtil createRequestURL:FAVORITES_URL withParam:param];
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
    [receivedData release];
    [favoritesArray release];
    [removeInfo release];
    [removeConn release];
    [listConn release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favoritesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    FavoriteInfo *info = [self.favoritesArray objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=2;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",info.goodsName,[[info.mallPrice fillZeroAtStart] RMBFormat]];
    cell.imageView.image=[UIMakerUtil createImageViewFromURL:info.picAddr].image;
    cell.textLabel.textAlignment= UITextAlignmentLeft;
    cell.detailTextLabel.numberOfLines=1;
    cell.detailTextLabel.text=[[info.mallPrice fillZeroAtStart] RMBFormat];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    FavoriteInfo *info=[self.favoritesArray objectAtIndex:indexPath.row];
    Product *product=[Product productWithId:info.goodsId];
    ProductDetailViewController *view=[[[ProductDetailViewController alloc] init] autorelease];
    view.productData=product;
    [[self navigationController] pushViewController:view animated:YES];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// delete item
    FavoriteInfo *info=[self.favoritesArray objectAtIndex:indexPath.row];
    receivedData=[[NSMutableData alloc] initWithData:nil];
    self.removeInfo=info;
    NSString *param=[NSString stringWithFormat:@"&cusId=%@&goodsId=%@",[SessionUtil sharedInstance].userInformation.cusId,info.goodsId];
    NSString *url=[ConstantUtil createRequestURL:REMOVE_FAVORITES_URL];
    self.removeConn=[DataSource createPostConn:url param:param delegate:self];
}

-(void)enterEditMode
{
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	[self.tableView setEditing:YES animated:YES];
}

-(void)leaveEditMode
{
	[self.tableView setEditing:NO animated:YES];
}


@end
