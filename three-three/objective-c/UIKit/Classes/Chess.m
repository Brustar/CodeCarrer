//
//  Chess.m
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Chess.h"

@implementation Chess
@synthesize circle,index,number,type,chessImage,center;

+(id) ChessWithPoint:(CGPoint) point
{
	Chess *chess=[[[Chess alloc] init] autorelease];
	chess.circle=[self circle:point];
	chess.index=[self index:point];
	chess.number=[self chessNum:point];
	return chess;
}

+(int) circle:(CGPoint) point
{
	int temp=[self chessNum:point];
	return temp % 8;
}

+(int) index:(CGPoint) point
{
	int temp=[self chessNum:point];
	return temp / 8;
}

+(BOOL) isClickable:(CGPoint) point
{
	if ([self chessNum:point]!=-1) {
		return YES;
	}
	return NO;
}

+(NSArray *) siblingNumbers:(int) num
{
	NSMutableArray *retArray=[[[NSMutableArray alloc] init] autorelease];
	int cir=num / 8; 
	int ind=num % 8;
	if (ind!=0){
		[retArray addObject: [NSNumber numberWithInt:num+1]];
		[retArray addObject: [NSNumber numberWithInt:num-1]];
	}else{
		[retArray addObject: [NSNumber numberWithInt:num+1]];
		[retArray addObject: [NSNumber numberWithInt:num+7]];
	}	

	if(cir==0){
		[retArray addObject: [NSNumber numberWithInt:num+8]];
	}else if (cir==1){
		[retArray addObject: [NSNumber numberWithInt:num-8]];
		[retArray addObject: [NSNumber numberWithInt:num+8]];
	}else{
		[retArray addObject: [NSNumber numberWithInt:num-8]];
	}
	
	return retArray;
}

+(NSArray *)PointsInLinesOfCurrentChessNum:(int) num
{
	NSMutableArray *retArray=[[[NSMutableArray alloc] init] autorelease];
	NSMutableArray *sla=[[[NSMutableArray alloc] initWithCapacity:3] autorelease];
	NSMutableArray *slb=[[[NSMutableArray alloc] initWithCapacity:3] autorelease];
	NSMutableArray *sw=[[[NSMutableArray alloc] initWithCapacity:3] autorelease];
	int cir=num / 8; 
	int ind=num % 8;
	if(ind%2==0) {
		if (ind==6){
			[sla addObject: [NSNumber numberWithInt:num-6]];
			[sla addObject: [NSNumber numberWithInt:num+1]];
		}else{
			[sla addObject: [NSNumber numberWithInt:num+1]];
			[sla addObject: [NSNumber numberWithInt:num+2]];
		}
		if(ind==0){
			[slb addObject: [NSNumber numberWithInt:num+6]];
			[slb addObject: [NSNumber numberWithInt:num+7]];
		}else{
			[slb addObject: [NSNumber numberWithInt:num-1]];
			[slb addObject: [NSNumber numberWithInt:num-2]];
		}	
	}else if (ind==7){
		[sla addObject: [NSNumber numberWithInt:num-1]];
		[sla addObject: [NSNumber numberWithInt:num-7]];
	}else{
		[sla addObject: [NSNumber numberWithInt:num-1]];
		[sla addObject: [NSNumber numberWithInt:num+1]];
	}
	if(cir==0){
		[sw addObject: [NSNumber numberWithInt:num+8]];
		[sw addObject: [NSNumber numberWithInt:num+16]];
	}else if (cir==1){
		[sw addObject: [NSNumber numberWithInt:num-8]];
		[sw addObject: [NSNumber numberWithInt:num+8]];
	}else{
		[sw addObject: [NSNumber numberWithInt:num-8]];
		[sw addObject: [NSNumber numberWithInt:num-16]];
	}
	[retArray addObject: sla];
	[retArray addObject: sw];
	if([slb count]>0) [retArray addObject: slb];

	return retArray;
}

+(NSArray *)PointsInLinesOfCurrentChess:(CGPoint) point
{
	return [self PointsInLinesOfCurrentChessNum:[Chess chessNum:point]];
}

+(int) chessNum:(CGPoint) point
{
	float x=point.x,y=point.y;
	if (x<CHESS_SIZE && y<CHESS_SIZE) {
		return	0;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE) {
		return	1;
	}else if(x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE){
		return	2;
	}else if (x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	3;
	}else if(x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6){
		return	4;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6) {
		return	5;
	}else if(x<CHESS_SIZE && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6){
		return	6;
	}else if (x<CHESS_SIZE && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	7;
	}else if(x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1){
		return	8;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1) {
		return	9;
	}else if(x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1){
		return	10;
	}else if (x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	11;
	}else if(x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5){
		return	12;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5) {
		return	13;
	}else if(x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5){
		return	14;
	}else if (x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	15;
	}else if(x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2){
		return	16;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2) {
		return	17;
	}else if(x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2){
		return	18;
	}else if (x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	19;
	}else if(x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4){
		return	20;
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4) {
		return	21;
	}else if(x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4){
		return	22;
	}else if (x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	23;
	}
	
	return -1;
}

+(CGPoint) chessCenter:(CGPoint) point
{
	float x=point.x,y=point.y;
	if (x<CHESS_SIZE && y<CHESS_SIZE) {
		return	CGPointMake(0,0);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE) {
		return	CGPointMake(GRANULARITY*3,0);
	}else if(x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE){
		return	CGPointMake(GRANULARITY*6,0);
	}else if (x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(GRANULARITY*6,GRANULARITY*3);
	}else if(x<CHESS_SIZE+GRANULARITY*6 && x>GRANULARITY*6 && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6){
		return	CGPointMake(GRANULARITY*6,GRANULARITY*6);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6) {
		return	CGPointMake(GRANULARITY*3,GRANULARITY*6);
	}else if(x<CHESS_SIZE && y<CHESS_SIZE+GRANULARITY*6 && y>GRANULARITY*6){
		return	CGPointMake(0,GRANULARITY*6);
	}else if (x<CHESS_SIZE && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(0,GRANULARITY*3);
	}else if(x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1){
		return	CGPointMake(GRANULARITY,GRANULARITY);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1) {
		return	CGPointMake(GRANULARITY*3,GRANULARITY);
	}else if(x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*1 && y>GRANULARITY*1){
		return	CGPointMake(GRANULARITY*5,GRANULARITY);
	}else if (x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(GRANULARITY*5,GRANULARITY*3);
	}else if(x<CHESS_SIZE+GRANULARITY*5 && x>GRANULARITY*5 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5){
		return	CGPointMake(GRANULARITY*5,GRANULARITY*5);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5) {
		return	CGPointMake(GRANULARITY*3,GRANULARITY*5);
	}else if(x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*5 && y>GRANULARITY*5){
		return	CGPointMake(GRANULARITY,GRANULARITY*5);
	}else if (x<CHESS_SIZE+GRANULARITY*1 && x>GRANULARITY*1 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(GRANULARITY,GRANULARITY*3);
	}else if(x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2){
		return	CGPointMake(GRANULARITY*2,GRANULARITY*2);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2) {
		return	CGPointMake(GRANULARITY*3,GRANULARITY*2);
	}else if(x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*2 && y>GRANULARITY*2){
		return	CGPointMake(GRANULARITY*4,GRANULARITY*2);
	}else if (x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(GRANULARITY*4,GRANULARITY*3);
	}else if(x<CHESS_SIZE+GRANULARITY*4 && x>GRANULARITY*4 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4){
		return	CGPointMake(GRANULARITY*4,GRANULARITY*4);
	}else if (x<CHESS_SIZE+GRANULARITY*3 && x>GRANULARITY*3 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4) {
		return	CGPointMake(GRANULARITY*3,GRANULARITY*4);
	}else if(x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*4 && y>GRANULARITY*4){
		return	CGPointMake(GRANULARITY*2,GRANULARITY*4);
	}else if (x<CHESS_SIZE+GRANULARITY*2 && x>GRANULARITY*2 && y<CHESS_SIZE+GRANULARITY*3 && y>GRANULARITY*3) {
		return	CGPointMake(GRANULARITY*2,GRANULARITY*3);
	}
	
	return CGPointZero;
}

@end
