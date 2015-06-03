//
//  GameView.h
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import	"UIMakerUtil.h"
#import "Chess.h"

enum Game{
    PositionChess, 
    ReadyEatChess,  
    SelectChess,
    MoveChess,
	EndGame
} GameState;

@interface GameView : UIView {
	BOOL isRedGo;
	NSMutableArray *chessesOnDisk;
}

-(Chess *) borderChess;
-(void)	fadeOutChess;
-(BOOL) hasEmptySiblingChess:(Chess *) chess;
-(Chess *) queryChess:(CGPoint) point;

@end
