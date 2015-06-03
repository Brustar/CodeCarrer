//
//  GameView.m
//  ThreeChessGame
//
//  Created by brustar on 12-6-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation GameView

- (void) playSound:(NSString *)name
{
	SystemSoundID mysound;
	// create the sound
	NSString *sndpath = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
	CFURLRef baseURL = (CFURLRef)[NSURL fileURLWithPath:sndpath];
	
	// Identify it as not a UI Sound
    AudioServicesCreateSystemSoundID(baseURL, &mysound);
	AudioServicesPropertyID flag = 0;  // 0 means always play
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &mysound, sizeof(AudioServicesPropertyID), &flag);
	
	if ([MPMusicPlayerController iPodMusicPlayer].playbackState ==  MPMusicPlaybackStatePlaying)
		AudioServicesPlayAlertSound(mysound);
	else
		AudioServicesPlaySystemSound(mysound);
}

- (void) vibrate
{
	AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

-(void) printChesses
{
	for (Chess *chess in chessesOnDisk) {
		NSLog(@"chess:%d,%d",chess.number,chess.type);
	}
}

-(void) resetChesses
{
	for (Chess *chess in chessesOnDisk) {
		[chess.chessImage removeFromSuperview];
	}
	[chessesOnDisk removeAllObjects];
}

-(Chess *) queryChess:(CGPoint) point
{
	for (Chess *chess in chessesOnDisk){
		if (chess.number==[Chess chessNum:point]) {
			return chess;
		}
	}
	return nil;
}

-(Chess *) chessOfNumber:(NSNumber *) num
{
	for (Chess *chess in chessesOnDisk){
		if (chess.number==num.intValue) {
			return chess;
		}
	}
	return nil;
}

-(Chess *)borderChess
{
	for (Chess *chess in chessesOnDisk){
		if (chess.type==border) {
			return chess;
		}
	}
	return nil;
}

-(BOOL) fullChess
{
	for (Chess *chess in chessesOnDisk){
		if (chess.type==empty) {
			return NO;
		}
	}
	return YES;
}

-(BOOL) isGameOver
{
	int r=0,b=0;
	for (Chess *chess in chessesOnDisk){
		if (chess.type==red) {
			r++;
		}
		if (chess.type==black) {
			b++;
		}
	}
	if (r<3 || b<3) {
		return YES;
	}
	else {
		return NO;
	}

}

-(BOOL) noMoveChess
{
	int color=red;
	if (isRedGo) {
		color=black;
	}
	for (Chess *chess in chessesOnDisk){
		if (chess.type==color) {
			if ([self hasEmptySiblingChess :chess]) {
				return NO;
			}
		}
	}
	return YES;
}

-(void) endGame
{
	if ([self isGameOver] || [self noMoveChess]) {
		NSString *side=@"";
		if(!isRedGo){
			side=@"红方";
		}else {
			side=@"黑方";
		}
		side=[side stringByAppendingString:@"赢了,再来一局吗?"];
		[UIMakerUtil confirm:side title:@"恭喜" delegate:self];
	}
}

-(BOOL) isAlreadyPutChess:(Chess *) chess
{
	return chess!=nil;
}

-(BOOL) isEmptyChess:(Chess *) chess
{
	return chess.type==empty;
}

-(BOOL) isPutOnFadeOutChess:(Chess *) chess
{
	return chess.type==limpidity;
}

-(BOOL) canPositionChess:(CGPoint) point
{
	Chess *chess=[self queryChess:point];
	return [Chess isClickable:point] && ![self isAlreadyPutChess:chess];
}

-(BOOL) canEatChess:(Chess *) chess
{
	return [self isAlreadyPutChess:chess] && [self isPutOnFadeOutChess:chess];
}

//棋眼有棋，并且有相邻空格,黑棋先走
-(BOOL) canSelectChess:(Chess *) chess
{
	return ![self isEmptyChess:chess] && [self hasEmptySiblingChess:chess] && isRedGo==(chess.type==red);
}

-(BOOL) hasEmptySiblingChess:(Chess *) chess
{
	for (NSNumber *num in [Chess siblingNumbers:chess.number]) {
		if ([[self chessOfNumber:num] type]==empty) {
			return YES;
		}
	}
	return NO;
}

//当前棋眼是不是要移动棋的邻格
-(BOOL) isSiblingChess:(Chess *) chess
{
	NSArray *array=[Chess siblingNumbers:[[self borderChess] number]];
	NSNumber *num=[[[NSNumber alloc] initWithInt:chess.number] autorelease];
	return	[array containsObject:num];
}

-(BOOL) canMoveChess:(Chess *) chess
{
	return [self isEmptyChess:chess] && [self isSiblingChess:chess];
}
//here is issue
-(void)removeFlagChesses
{	
	if ([chessesOnDisk count]==24) {
		if ([self fullChess]) {
			isRedGo=NO;	//黑方开始走棋
		}

		for (Chess *chess in chessesOnDisk) {
			if (chess.type==flag) {//
				[chess.chessImage removeFromSuperview];
				chess.type=empty;
			}
		}
	}
}

-(BOOL) isThreeLine:(CGPoint) point
{
	BOOL isLine=YES;
	for (NSArray *array in [Chess PointsInLinesOfCurrentChess:point]) {
		for (NSNumber *num in array) {
			Chess *chess=[self chessOfNumber:num];
			if (chess.type==red) {
				if (isRedGo) {
					isLine= NO;
					break;
				}
			}else if(chess.type==black){
				if (!isRedGo) {
					isLine= NO;
					break;
				}
			}else {
				isLine= NO;
				break;
			}
			isLine=YES;
		}
		if (isLine) {
			return YES;
		}
	}
	return NO;
}

-(void) threeLine:(CGPoint) point 
{
	if ([self isThreeLine:point]) {
		[self fadeOutChess];
		GameState=ReadyEatChess;
	}else {
		if ([chessesOnDisk count]==24) {
			if (![self fullChess]) {
				GameState=SelectChess;
			}else {
				[UIMakerUtil confirm:@"和棋，再来一局吗？" title:@"提示" delegate:self];
			}
		}
	}
}

-(void) moveChess:(Chess *) chess
{
	Chess *readyMoveChess=[self borderChess];
	if (!isRedGo) {
		chess.type=black;
		CFShow(chess.chessImage);
		chess.chessImage.image=[UIImage imageNamed:@"Chess_B"];
	}else {
		chess.type=red;
		chess.chessImage.image=[UIImage imageNamed:@"Chess_R"];
	}
	[self addSubview:chess.chessImage];
	[[readyMoveChess chessImage] removeFromSuperview];
	readyMoveChess.type=empty;
	[self endGame];
}

-(void) border:(Chess *) chess
{	
	NSString *imageName=chess.type==red?@"Chess_R":@"Chess_B";
	Chess *readyChess=[self borderChess];
	[readyChess chessImage].image=[UIImage imageNamed:imageName];
	readyChess.type=chess.type;
	imageName=chess.type==red?@"Chess_Box_R":@"Chess_Box_B";
	chess.chessImage.image=[UIImage imageNamed:imageName];
	chess.type=border;
}

-(void)	fadeOutChess
{
	if (!isRedGo) {
		for (Chess *chess in chessesOnDisk) {
			if (chess.type==black) {
				chess.type=limpidity;
				[UIMakerUtil fadeOut:chess.chessImage];
			}
		}
	} else {
		for (Chess *chess in chessesOnDisk) {
			if (chess.type==red) {
				chess.type=limpidity;
				[UIMakerUtil fadeOut:chess.chessImage];
			}
		}
	}
}

-(void)	fadeIn
{
	for (Chess *chess in chessesOnDisk) {
		if (chess.type==limpidity) {
			if(isRedGo){
				chess.type=red;
			}
			else{
				chess.type=black;
			}
			[UIMakerUtil fadeIn:chess.chessImage];
		}
	}
	[self endGame];
}

-(Chess *)createChess:(NSString *)image point:(CGPoint) point
{
	UIImageView *view=[UIMakerUtil createImageView:image];
	point.x+=CHESS_SIZE/2;
	point.y+=CHESS_SIZE/2;
	view.center= point;
	Chess *chess=[Chess ChessWithPoint:point];	
	if ([image hasSuffix :@"R"]) {
		chess.type=red;
	}else{
		chess.type=black;
	}
	chess.chessImage=view;
	chess.center=point;
	if (![chessesOnDisk containsObject:chess]) {
		[chessesOnDisk addObject:chess];
	}
	[self removeFlagChesses];
	return chess;
}

-(void)replaceChess:(NSString *)image withChess:(Chess *) chess
{
	chess.chessImage.image=[UIImage imageNamed:image];
	chess.type=flag;
	[UIMakerUtil fadeIn:chess.chessImage];
	[self removeFlagChesses];
}

-(void) putRChess:(CGPoint) point
{
	Chess *chess=[self createChess:@"chess_R" point:point];
	[self addSubview:chess.chessImage];
}

-(void) putBChess:(CGPoint) point
{
	Chess *chess=[self createChess:@"chess_B" point:point];
	[self addSubview:chess.chessImage];
}

-(void) putEatChess:(Chess *) chess
{
	NSString *imageName=@"";
	if (isRedGo) {
		imageName=@"chess_B_R";
	}else{
		imageName=@"chess_R_B";
	}
	[self replaceChess:imageName withChess:chess];

	[self fadeIn];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		isRedGo=YES;
		GameState=PositionChess;
		frame.origin.x=0;
		chessesOnDisk=[[NSMutableArray alloc] initWithCapacity:24];
		[self addSubview:[UIMakerUtil createImageView:@"disk" frame:frame]];
    }
    return self;
}

- (void)dealloc {
	[chessesOnDisk dealloc];
    [super dealloc];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self resetChesses];
		GameState=PositionChess;
    }else {
		GameState=EndGame;
	}

}

#pragma mark scrolldelegate methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point=[touch locationInView:[touch view]];
	Chess *chess=[self queryChess:point];	//格上有棋时，点击的棋子及状态
	switch (GameState) {
		case PositionChess:
			if ([self canPositionChess:point]) { //布局时棋格上还没有棋，所以用point
				if (isRedGo) {
					isRedGo=!isRedGo;
					[self putRChess:[Chess chessCenter:point]];
				}else {
					isRedGo=!isRedGo;
					[self putBChess:[Chess chessCenter:point]];
				}
				//[self playSound:@"down"];
				[self threeLine:point];
			}
			break;
		case ReadyEatChess:
			if ([self canEatChess:chess]) {
				[self putEatChess:chess];
				if ([chessesOnDisk count]==24) {
					GameState=SelectChess;
				}else {
					GameState=PositionChess;
				}
			}
			break;
		case SelectChess:
			if ([self canSelectChess:chess]) {
				[self border:chess];
				GameState=MoveChess;
			}
			break;
		case MoveChess:
			//选择其他同色棋
			if ([self canSelectChess:chess]) {
				[self border:chess];
			}
			//移棋
			if ([self canMoveChess:chess]) { 
				[self moveChess:chess];
				GameState=SelectChess;
				isRedGo=!isRedGo;
				[self threeLine:point];
			}
			break;
		default:
			break;
	}
	[self printChesses];
	NSLog(@"%@\n",isRedGo?@"红方走棋中...":@"黑方走棋中...");
}

@end
