//
//  taxMircoBlogTests.m
//  taxMircoBlogTests
//
//  Created by Brustar XRL on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "taxMircoBlogTests.h"

@implementation taxMircoBlogTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    
    
    char     *utf8CString =  "Copyright \xC2\xA9 \xE2\x89\x85 2008";
    NSString *regexString = @"Copyright (.*) (\\d+)";
    
    NSString *subjectString = [NSString stringWithUTF8String:utf8CString];
    NSString *matchedString = [subjectString stringByMatching:regexString capture:1L];

    NSLog(@"subject: \"%@\"", subjectString);
    NSLog(@"matched: \"%@\"", matchedString);
    
    NSString *mail=@"2e234@f44.com.ddk.dk";
    NSLog(@"---%u",[mail isMatchedByRegex:@"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"]);
    //STFail(@"Unit tests are not implemented yet in taxMircoBlogTests");
    NSLog(@"****%d",[@"姓名不能为空" length]);
    NSLog(@"****%d",[@"abcdef" length]);
    CFShow([PlistUtil arrayFromPlist]);
}

@end
