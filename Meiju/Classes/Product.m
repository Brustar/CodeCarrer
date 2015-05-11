
/*
     File: Product.m
 Abstract: Simple class to represent a product, with a product type and name.
  Version: 1.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "Product.h"

@implementation Product

@synthesize pid, name, type, picURL, mallPrice, detail, virtualSalesVolume, markPrice, picAddr,invenStatus,saleRemark;

- (id) fetchWithProduct:(NSString *)json
{
	if (!self.name) {
		self.name=[DataSource fetchValueFormJsonObject:json forKey:PRO_NAME_KEY];
	}
	if (!self.mallPrice) {
		self.mallPrice=[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"mallPrice"]];
	}
	self.detail=[DataSource fetchValueFormJsonObject:json forKey:@"introdu"];
	self.virtualSalesVolume=[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"virtualSalesVolume"] ];
	self.markPrice=[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"markPrice"]];
	self.picAddr=[NSArray arrayWithArray:(NSArray *)[DataSource fetchValueFormJsonObject:json forKey:PIC_KEY] ];
	self.invenStatus=[NSString stringWithFormat:@"%@",[DataSource fetchValueFormJsonObject:json forKey:@"invenStatus"]];
	self.saleRemark=[DataSource fetchValueFormJsonObject:json forKey:@"saleRemark"];
	return self;
}

+ (id)productWithId:(NSString *)proId
{
	Product *newProduct = [[[self alloc] init] autorelease];
	newProduct.pid = proId;
	return newProduct;
}

+ (id)productWithId:(NSString *)proId picURL:(NSString *)url
{
	Product *newProduct = [self productWithId:proId];
	newProduct.picURL=url;
	return newProduct;
}

+ (id)productWithId:(NSString *)proId name:(NSString *)name url:(NSString *)url price:(NSString *)price
{
	Product *newProduct = [self productWithId:proId picURL:url];
	newProduct.name = name;
	newProduct.mallPrice=price;
	return newProduct;
}

-(id) createProduct:(NSString *)proId
{
	NSString *param=[NSString stringWithFormat:@"%@=%@&isFromAD=1",DETAIL_PARAM_KEY,pid];
	NSString *prosUrl=[ConstantUtil createRequestURL:DETAIL_URL withParam:param];
	
	Product *newProduct= [Product productWithId:proId];
	newProduct.name=[DataSource synValueFormJsonObject:prosUrl forKey:PRO_NAME_KEY];
	newProduct.mallPrice=[NSString stringWithFormat:@"%@",[DataSource synValueFormJsonObject:prosUrl forKey:@"mallPrice"]];
	newProduct.detail=[DataSource synValueFormJsonObject:prosUrl forKey:@"introdu"];
	newProduct.invenStatus=[NSString stringWithFormat:@"%@",[DataSource synValueFormJsonObject:prosUrl forKey:@"invenStatus"]];
	newProduct.virtualSalesVolume=[NSString stringWithFormat:@"%@",[DataSource synValueFormJsonObject:prosUrl forKey:@"virtualSalesVolume"] ];
	newProduct.markPrice=[NSString stringWithFormat:@"%@",[DataSource synValueFormJsonObject:prosUrl forKey:@"markPrice"]];
	newProduct.picAddr=[NSArray arrayWithArray:(NSArray *)[DataSource synValueFormJsonObject:prosUrl forKey:PIC_KEY] ];
	newProduct.saleRemark=[DataSource synValueFormJsonObject:prosUrl forKey:@"saleRemark"];
	return newProduct;
}

- (void)dealloc
{
	[pid release];
	[type release];
	[name release];
	[picURL release];
	[mallPrice release];
	[markPrice release];
	[picAddr release];
	[super dealloc];
}

@end
