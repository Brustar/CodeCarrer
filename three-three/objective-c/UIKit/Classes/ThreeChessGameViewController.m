//
//  ThreeChessGameViewController.m
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ThreeChessGameViewController.h"

@implementation ThreeChessGameViewController

-(void)createGameUI
{
	[self.view addSubview:[[[GameView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_HEIGHT)/2, 0, SCREEN_HEIGHT, SCREEN_HEIGHT)] autorelease]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self createGameUI];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
