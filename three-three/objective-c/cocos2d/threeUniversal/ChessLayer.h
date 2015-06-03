//
//  ChessLayer.h
//  threeUniversal
//
//  Created by 肖智伟 on 13-4-11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ThreeLib.h"
#import "SimpleAudioEngine.h"

enum {
	RED	,
	BLACK
} _whoGo;

enum {
    PositionChess,
    ReadyEatChess,
    SelectChess,
    MoveChess,
	EndGame
} _gameState;

typedef struct _ThreeCount
{
	int y0;
    int y1;
    int y2;
    int y3;
    
    int y5;
    int y6;
    int y7;
    int y8;
    
    int b036;
    int b678;
    int b258;
    int b012;
    
    int m036;
    int m678;
    int m258;
    int m012;
    
    int i036;
    int i678;
    int i258;
    int i012;
} Count;

#define TAG_START_RED			100
#define TAG_START_BLACK			200
#define TAG_COVER               999
#define TAG_MENU_AGAIN          998
#define TAG_MENU                997


@interface ChessLayer : CCLayer{
    CCSpriteBatchNode * _disk;
    CGPoint             _prePoint;
    CGSize              _winSize;
    float               _offsetX;
    float               _gridWidth;
    float               _chessOrPaddingWidth;
}

+(CCScene *) scene;

//- (CGPoint)locationInView:(UIView *)view;

@end
