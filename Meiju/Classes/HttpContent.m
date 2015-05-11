//
//  PostWebContentViewController.m
//  PostWebContent
//

#import "HttpContent.h"

@implementation HttpContent


/*
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
	 json = [[NSString alloc] 
						 initWithBytes:[receivedData bytes] 
						 length:[receivedData length] 
						 encoding:NSASCIIStringEncoding];
}
*/
static HttpContent *conn=nil;
+(HttpContent *) sharedHttpContent
{
	if (!conn) {
		conn=[[self alloc] init];		
	}
	return conn;
}

- (NSURLConnection *)createPostConnection:(NSURL *)url param:(NSString *)param delegate:(id) obj
{

	//NSURL *url = [NSURL URLWithString:[ConstantUtil createBaseRequestURL:doUrl]];
	NSMutableURLRequest *req=[[[NSMutableURLRequest alloc] 
								initWithURL:url 
								cachePolicy:NSURLRequestReloadIgnoringLocalCacheData 
								timeoutInterval:30.0] autorelease];
	[req setHTTPMethod: @"POST"];
	[req setHTTPBody:[param dataUsingEncoding:NSISOLatin1StringEncoding]];
	NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:req delegate:obj];
	return [con autorelease];
}

-(NSURLConnection *)createGetConnection:(NSURL *)url delegate:(id) obj
{
	NSURLRequest *req=[[[NSURLRequest alloc] initWithURL:url] autorelease];
	NSURLConnection *con= [[NSURLConnection alloc] initWithRequest:req delegate:obj];
	return [con autorelease];
}

- (void)dealloc {
	[conn release];
	[super dealloc];
}

@end
