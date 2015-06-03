//
//  Chess.h
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHESS_SIZE	50
#define GRANULARITY 120

enum Type{
	empty,
    red, 
    black,  
    flag,	//被压的棋
	limpidity,
    border
} ChessType;

@interface Chess : NSObject {
	int circle;
	int index;
	int number;
	int type;
	CGPoint center;
	UIImageView *chessImage;
}

@property (nonatomic) int circle,index,number,type;
@property (nonatomic) CGPoint center;
@property (nonatomic,retain) UIImageView *chessImage;

+(id) ChessWithPoint:(CGPoint) point;
+(int) circle:(CGPoint) point;
+(int) index:(CGPoint) point;
+(BOOL) isClickable:(CGPoint) point;
+(NSArray *) siblingNumbers:(int) num;
+(NSArray *)PointsInLinesOfCurrentChessNum:(int) cn;
+(NSArray *)PointsInLinesOfCurrentChess:(CGPoint) point;
+(int) chessNum:(CGPoint) point;
+(CGPoint) chessCenter:(CGPoint) point;

@end
