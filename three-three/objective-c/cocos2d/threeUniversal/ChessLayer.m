//
//  ChessLayer.m
//  threeUniversal
//
//  Created by 肖智伟 on 13-4-11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ChessLayer.h"


@implementation ChessLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChessLayer *layer = [ChessLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;

        _winSize = [[CCDirector sharedDirector] winSize];
        _offsetX = (_winSize.width - _winSize.height) / 2;
        _chessOrPaddingWidth = isDeviceIPad()?48:20;
        _gridWidth = (_winSize.height - _chessOrPaddingWidth * 2) / 6;
        
        // scheduling the update method in order to adjust the game state every frame
		[self scheduleUpdate];
        
        [self initDisk];
        [self initSound];
	}
	return self;
}

- (void)initSound
{
	[[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.3f];
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"back.caf" loop:YES];
}

-(void) initDisk
{
    _disk=[CCSprite spriteWithSpriteFrameName:@"disk.png"];
    _disk.position = ccp(_winSize.width/2, _winSize.height/2);
    [self addChild: _disk];
}

#pragma mark - update game state
-(void) update:(ccTime)delta
{
    NSString *title=(_whoGo==RED)?@"Red":@"Black";
    title=[title stringByAppendingString: @" player win!" ];
    NSString *peaceTitle=@"Peace game.";
    
    int chessCount=[[_disk children] count];
    if (chessCount>=12 && chessCount<24 && _gameState>0) {
        if ([self noMoveOfBlack] || [self noMoveOfRed]) {
            [self showWin:title];
            _gameState=EndGame;
            [self unscheduleUpdate];
        }
    }

    if(_gameState<1 && [self diskChessFull])
    {
        [self showWin:peaceTitle];
        _gameState=EndGame;
        [self unscheduleUpdate];
    }
    
    if (_gameState>1 && [self winGame]) {
        [self showWin:title];
        _gameState=EndGame;
        [self unscheduleUpdate];
    }
}

#pragma mark -  public method
//touch坐标转棋盘上的坐标
- (CGPoint)pointOfView:(CGPoint)point
{
	int x = -1;
	int y = -1;
	if (point.x >_offsetX && point.x < _offsetX + _winSize.height)
		x = (point.x - _offsetX - _chessOrPaddingWidth/2) / _gridWidth;
    y = (point.y - _chessOrPaddingWidth/2) / _gridWidth;

    if ([self validatePoint:CGPointMake(x, y)]) {
        return CGPointMake(x, y);
    } 
    //NSLog(@"x:%d,y:%d",x,y);
	return CGPointMake(-1, -1);
}

//棋盘上各个点的cocos坐标
-(CGPoint)chessPos:(CGPoint)currentPoint
{
    CGFloat x = _chessOrPaddingWidth + currentPoint.x * _gridWidth;
    CGFloat y = _chessOrPaddingWidth + currentPoint.y * _gridWidth;
    y=_winSize.height-y;
    CGPoint pos= CGPointMake((int)x,(int)y);
    return pos;
}

//棋盘上各个点的标识
-(int) chessTag:(CGPoint)point
{
    int tag=0;
    for (int x=0; x<=6; x+=3) {
        for (int y=0; y<=6; y+=3) {
            if (point.x==x && point.y==y) {
                return tag;
            }
            tag++;
        }
    }
    tag=0;
    for (int x=1; x<=5; x+=2) {
        for (int y=1; y<=5; y+=2) {
            if (point.x==x && point.y==y) {
                return 10+tag;
            }
            tag++;
        }
    }
    tag=0;
    for (int x=2; x<=4; x++) {
        for (int y=2; y<=4; y++) {
            if (point.x==x && point.y==y) {
                return 20+tag;
            }
            tag++;
        }
    }
    return -1;
}

-(int) fetchTag:(CGPoint)point
{
    int tag=[self chessTag:point];
    if (tag!=-1) {
        return [self selfColorBit]+tag;
    }
    return -1;
}

//{{0,0},{3,0},{6,0},{6,3},{6,6},{3,6},{0,6},{0,3},
// {1,1},{3,1},{5,1},{5,3},{5,5},{3,5},{1,5},{3,1},
// {2,2},{3,2},{4,2},{4,3},{4,4},{3,4},{2,4},{2,3}};
-(BOOL) validatePoint:(CGPoint)point
{
    if (point.x<0 || point.y<0) {
        return NO;
    }
    if (point.x==3 && point.y==3) {
        return NO;
    }
    for (int x=0; x<=6; x+=3) {
        for (int y=0; y<=6; y+=3) {
            if (point.x==x && point.y==y) {
                return YES;
            }
        }
    }
    for (int x=1; x<=5; x+=2) {
        for (int y=1; y<=5; y+=2) {
            if (point.x==x && point.y==y) {
                return YES;
            }
        }
    }
    for (int x=2; x<=4; x++) {
        for (int y=2; y<=4; y++) {
            if (point.x==x && point.y==y) {
                return YES;
            }
        }
    }
    return NO;
}

-(BOOL) emptyNode:(CGPoint) currentPoint
{
    CGPoint pos=[self chessPos:currentPoint];
    for( CCNode *node in [_disk children] ){
        CGPoint nodepos=node.position;
        if (pos.x==nodepos.x && pos.y==nodepos.y) {
            return NO;
        }
    }
    return YES;
}

-(void)goChess:(CGPoint)currentPoint
{
    CGPoint pos=[self chessPos:currentPoint];
    
    int tag=[self fetchTag:currentPoint];

    if ([self emptyNode:currentPoint]) {
        NSString *imageName = _whoGo==RED?@"chessR.png":@"chessB.png";
        CCSprite *chess=[CCSprite spriteWithSpriteFrameName:imageName];
        chess.position = pos;
        chess.tag=tag;
        //NSLog(@"tag:%d",chess.tag);
        [[SimpleAudioEngine sharedEngine] playEffect:@"click.caf"];
        [_disk addChild: chess];
    }
}

//移除chessR.png或chessB.png
-(BOOL)replaceChess:(CGPoint)currentPoint
{
    int startTag=_whoGo==RED?TAG_START_BLACK:TAG_START_RED;
    int tag=[self chessTag:currentPoint]+startTag;
    CCNode *node= [_disk getChildByTag:tag];
    if (node) {
        [_disk removeChildByTag:tag cleanup:YES];

        NSString *imageName = _whoGo==RED?@"chessRCoverB.png":@"chessBCoverR.png";
        CCSprite *chess=[CCSprite spriteWithSpriteFrameName:imageName];
        chess.position = [self chessPos:currentPoint];
        chess.tag=TAG_COVER;
        [_disk addChild: chess];
        [[SimpleAudioEngine sharedEngine] playEffect:@"choose.wav"];
        return YES;
    }
    return NO;
}

//返回tag的最高位
-(int)selfColorBit
{
    if (_whoGo==RED) {
        return TAG_START_RED;
    }else{
        return TAG_START_BLACK;
    }
}

//返回tag的最高位
-(int)oppColorBit
{
    if (_whoGo!=RED) {
        return TAG_START_RED;
    }else{
        return TAG_START_BLACK;
    }
}

-(CCNode *) nodeFromPoint:(CGPoint)currentPoint
{
    int tag=[self fetchTag:currentPoint];
    return [_disk getChildByTag:tag];
}

-(void) zoomChess:(CGPoint)currentPoint size:(float)size
{
    CCNode *node=[self nodeFromPoint:currentPoint];
    if(node){
        [self unmarkChess];
        node.scale=size;
        [[SimpleAudioEngine sharedEngine] playEffect:@"choose.caf"];
    }
}

-(void) markChess
{
    for( CCNode *node in [_disk children] ){
        if(node.tag/100!=[self selfColorBit]/100 && node.tag!=-1 && node.tag!=TAG_COVER){
            node.scale=1.5;
        }
    }
}

-(void) unmarkChess
{
    for( CCNode *node in [_disk children] ){
        node.scale=1.0;
    }
}

-(BOOL)oppChess:(CGPoint) currentPoint
{
    for( CCNode *node in [_disk children] ){
        if (node.scale>1 && node.tag%100==[self chessTag:currentPoint]) {
            if (node.tag/100!=[self selfColorBit]/100) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(BOOL)lineThree:(CGPoint) currentPoint
{
    Count count={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    for( CCNode *node in [_disk children] ){
        if(node.tag/[self selfColorBit]==1){
            switch (node.tag % 10) {
                case 0:
                    count.y0++;
                    break;
                case 1:
                    count.y1++;
                    break;
                case 2:
                    count.y2++;
                    break;
                case 3:
                    count.y3++;
                    break;
                case 5:
                    count.y5++;
                    break;
                case 6:
                    count.y6++;
                    break;
                case 7:
                    count.y7++;
                    break;
                case 8:
                    count.y8++;
                    break;
                default:
                    break;
            }
            switch (node.tag / 10) {
                case 10:
                case 20:
                    if (node.tag%10==0 ||node.tag%10==3 ||node.tag%10==6 ) {
                        count.b036++;
                    }
                    if (node.tag%10==8 ||node.tag%10==7 ||node.tag%10==6 ) {
                        count.b678++;
                    }
                    if (node.tag%10==2 ||node.tag%10==5 ||node.tag%10==8 ) {
                        count.b258++;
                    }
                    if (node.tag%10==2 ||node.tag%10==1 ||node.tag%10==0 ) {
                        count.b012++;
                    }
                    break;
                case 11:
                case 21:
                    if (node.tag%10==0 ||node.tag%10==3 ||node.tag%10==6 ) {
                        count.m036++;
                    }
                    if (node.tag%10==8 ||node.tag%10==7 ||node.tag%10==6 ) {
                        count.m678++;
                    }
                    if (node.tag%10==2 ||node.tag%10==5 ||node.tag%10==8 ) {
                        count.m258++;
                    }
                    if (node.tag%10==2 ||node.tag%10==1 ||node.tag%10==0 ) {
                        count.m012++;
                    }
                    break;
                case 12:
                case 22:
                    if (node.tag%10==0 ||node.tag%10==3 ||node.tag%10==6 ) {
                        count.i036++;
                    }
                    if (node.tag%10==8 ||node.tag%10==7 ||node.tag%10==6 ) {
                        count.i678++;
                    }
                    if (node.tag%10==2 ||node.tag%10==5 ||node.tag%10==8 ) {
                        count.i258++;
                    }
                    if (node.tag%10==2 ||node.tag%10==1 ||node.tag%10==0 ) {
                        count.i012++;
                    }
                    break;
                default:
                    break;
            }
        }
    }
    if (count.y0==3 || count.y1==3 || count.y2==3 || count.y3==3 || count.y5==3 || count.y6==3 || count.y7==3 || count.y8==3
        || count.b012==3 || count.b036==3 || count.b258==3 || count.b678==3
        || count.m012==3 || count.m036==3 || count.m258==3 || count.m678==3
        || count.i012==3 || count.i036==3 || count.i258==3 || count.i678==3)
    {
        if ([self currenLine:currentPoint count:count]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)currenLine:(CGPoint) currentPoint count:(Count) count
{
    int tag=[self chessTag:currentPoint];
    switch (tag%10) {
        case 0:
            if (count.y0==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b036==3 || count.b012==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m036==3 || count.m012==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i036==3 || count.i012==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
        
        case 1:
            if (count.y1==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b012==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m012==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i012==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 2:
            if (count.y2==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b258==3 || count.b012==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m258==3 || count.m012==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i258==3 || count.i012==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 3:
            if (count.y3==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b036==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m036==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i036==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 5:
            if (count.y5==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b258==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m258==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i258==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 6:
            if (count.y6==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b036==3 || count.b678==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m036==3 || count.m678==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i036==3 || count.i678==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 7:
            if (count.y7==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b678==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m678==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i678==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        case 8:
            if (count.y8==3) {
                return YES;
            }
            switch (tag/10) {
                case 0:
                    if (count.b678==3 || count.b258==3) {
                        return YES;
                    }
                    break;
                case 1:
                    if (count.m678==3  || count.m258==3) {
                        return YES;
                    }
                    break;
                case 2:
                    if (count.i678==3 || count.i258==3) {
                        return YES;
                    }
                    break;
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    return NO;
}

-(BOOL)diskFull
{
    return [[_disk children] count]==24;
}

-(BOOL)diskChessFull
{
    int sum=0;
    for( CCNode *node in [_disk children] ){
        if (node.tag!=TAG_COVER) {
            sum++;
        }
    }
    return sum==24;
}

-(BOOL)removeCoverChess
{
    int remove=0;
    for( CCNode *node in [_disk children] ){
        if (node.tag==TAG_COVER) {
            [node removeFromParentAndCleanup:YES];
            remove++;
        }
    }
    return remove>0;
}

-(BOOL)sibNode:(CGPoint)currentPoint
{
    int tag=[self chessTag:currentPoint];
    int pretag=[self chessTag:_prePoint];
    if (tag%10==pretag%10) {
        if (abs(tag/10-pretag/10)==1) {
            return YES;
        }
    }
    
    int up=1; //第三圈
    if (tag/10%10==0) { //第一圈
        up=3;
    }else if(tag/10%10==1){ //第二圈
        up=2;
    }
    
    if (currentPoint.x==_prePoint.x) {
        if (abs(currentPoint.y-_prePoint.y)==up) {
            return YES;
        }
    }
    if (currentPoint.y==_prePoint.y) {
        if (abs(currentPoint.x-_prePoint.x)==up) {
            return YES;
        }
    }
    return NO;
}

//可下子
-(BOOL)canMovedinNode:(CGPoint)currentPoint
{
    if ([self emptyNode:currentPoint]) {
        if ([self sibNode:currentPoint]) {
            return YES;
        }
    }
    return NO;
}

//可移子
-(BOOL)canMovedoutNode:(CGPoint)currentPoint
{
    int tag=[self fetchTag:currentPoint];
    
    int modeTag=[self chessTag:currentPoint];
    if (tag!=-1) {
        if (modeTag+10<30) {
            if (![_disk getChildByTag:modeTag+TAG_START_RED+10] && ![_disk getChildByTag:modeTag+TAG_START_BLACK+10]) {
                return YES;
            }
        }

        if (modeTag-10>=0) {
            if (![_disk getChildByTag:modeTag+TAG_START_RED-10] && ![_disk getChildByTag:modeTag+TAG_START_BLACK-10]) {
                return YES;
            }
        }
    }
    
    int up=1; //第三圈
    if (tag/10%10==1) { //第二圈
        up=2;
    }else if(tag/10%10==0){ //第三圈
        up=3;
    }
    
    CGPoint zoomPoint=CGPointMake(currentPoint.x,currentPoint.y+up);
    if (currentPoint.y+up<=6) {
        if ([self validatePoint:zoomPoint] && [self emptyNode:zoomPoint]) {
            return YES;
        }
    }
    zoomPoint=CGPointMake(currentPoint.x,currentPoint.y-up);
    if (currentPoint.y-up>=0) {
        if ([self validatePoint:zoomPoint] && [self emptyNode:zoomPoint]) {
            return YES;
        }
    }
    zoomPoint=CGPointMake(currentPoint.x+up,currentPoint.y);
    if (currentPoint.x+up<=6) {
        if ([self validatePoint:zoomPoint] && [self emptyNode:zoomPoint]) {
            return YES;
        }
    }
    zoomPoint=CGPointMake(currentPoint.x-up,currentPoint.y);
    if (currentPoint.x-up>=0) {
        if ([self validatePoint:zoomPoint] && [self emptyNode:zoomPoint]) {
            return YES;
        }
    }
    
    return NO;
}

-(BOOL)eatChess:(CGPoint)currentPoint
{
    int tag=[self fetchTag:currentPoint];
    for( CCNode *node in [_disk children] ){
        if(node.tag!=-1 && node.tag!=TAG_COVER){
            if (node.tag==tag) {
                [node removeFromParentAndCleanup:YES];
                [self unmarkChess];
                [[SimpleAudioEngine sharedEngine] playEffect:@"eat.caf"];
                return YES;
            }
        }
    }
    return NO;
}

-(BOOL)winGame
{
    int rCount=0,bCount=0;
    for( CCNode *node in [_disk children] ){
        if (node.tag>=TAG_START_RED && node.tag<TAG_START_RED+29) {
            rCount++;
        }
        if (node.tag>=TAG_START_BLACK && node.tag<TAG_START_BLACK+29) {
            bCount++;
        }
    }
    if (rCount<3 || bCount<3) {
        return YES;
    }

    return NO;
}

-(CGPoint) gridOfTag:(int)tag
{
    tag=tag%100;//[self oppColorBit];
    int x=0;
    int y=0;
    if (tag/10==0) {
        switch (tag%10) {
            case 0:
                x=0;
                y=0;
                break;
            case 1:
                x=0;
                y=3;
                break;
            case 2:
                x=0;
                y=6;
                break;
            case 3:
                x=3;
                y=0;
                break;
            case 5:
                x=3;
                y=6;
                break;
            case 6:
                x=6;
                y=0;
                break;
            case 7:
                x=6;
                y=3;
                break;
            case 8:
                x=6;
                y=6;
                break;
            default:
                break;
        }
    }
    
    if (tag/10==1) {
        switch (tag%10) {
            case 0:
                x=1;
                y=1;
                break;
            case 1:
                x=1;
                y=3;
                break;
            case 2:
                x=1;
                y=5;
                break;
            case 3:
                x=3;
                y=3;
                break;
            case 5:
                x=3;
                y=5;
                break;
            case 6:
                x=5;
                y=1;
                break;
            case 7:
                x=5;
                y=3;
                break;
            case 8:
                x=5;
                y=5;
                break;
            default:
                break;
        }
    }
    
    if (tag/10==2) {
        switch (tag%10) {
            case 0:
                x=2;
                y=2;
                break;
            case 1:
                x=2;
                y=3;
                break;
            case 2:
                x=2;
                y=4;
                break;
            case 3:
                x=3;
                y=2;
                break;
            case 5:
                x=3;
                y=4;
                break;
            case 6:
                x=4;
                y=2;
                break;
            case 7:
                x=4;
                y=3;
                break;
            case 8:
                x=4;
                y=4;
                break;
            default:
                break;
        }
    }
    
    return CGPointMake(x, y);
}

-(BOOL) noMoveOfRed
{
    if ([[_disk children] count]<4) {
        return NO;
    }
    for( CCNode *node in [_disk children] ){
        if (node.tag>=TAG_START_RED && node.tag<TAG_START_RED+29) {
            if ([self canMovedoutNode:[self gridOfTag:node.tag]]) {
                return NO;
            }
            else{
                continue;
            }
        }
    }
    
    return YES;
}

-(BOOL) noMoveOfBlack
{
    if ([[_disk children] count]<4) {
        return NO;
    }
    for( CCNode *node in [_disk children] ){
        if (node.tag>=TAG_START_BLACK && node.tag<TAG_START_BLACK+29) {
            if ([self canMovedoutNode:[self gridOfTag:node.tag]]) {
                return NO;
            }else{
                continue;
            }
        }
    }
    return YES;
}

-(void)showWin:(NSString *)title
{
    CCLabelTTF *labelwin = [CCLabelTTF labelWithString:title fontName:@"Marker Felt" fontSize:isDeviceIPad()?64:32];
    labelwin.position =  ccp( _winSize.width /2 , _winSize.height/2+(isDeviceIPad()?40:20));
    labelwin.tag=TAG_MENU;
    [self addChild: labelwin];
    
    CCLabelTTF *playLabel = [CCLabelTTF labelWithString:@"play again" fontName:@"Marker Felt" fontSize:isDeviceIPad()?64:32];
    playLabel.position =  ccp( _winSize.width /2 , _winSize.height/2 -(isDeviceIPad()?40:20));
    playLabel.tag=TAG_MENU_AGAIN;
    [playLabel setColor:ccGREEN];
    [self addChild: playLabel];
    
    [labelwin runAction:[CCBlink actionWithDuration:1.5  blinks:5]];
    [[SimpleAudioEngine sharedEngine] playEffect:@"win.caf"];
}

#pragma mark -  touches method
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [self pointOfView:[touch locationInView:touch.view]];
    
	switch (_gameState) {
		case PositionChess: //
			if ([self validatePoint:currentPoint] && [self emptyNode:currentPoint])
            {
                [self goChess:currentPoint];
                if ([self lineThree:currentPoint]) {
                    _gameState=ReadyEatChess;
                    [self markChess];
                }else{
                    if ([self diskFull]) {
                        if ([self removeCoverChess]) {
                            _gameState=MoveChess;
                            _whoGo=BLACK;
                        }
                    }else
                       _whoGo=!_whoGo; 
                }
            }
			break;
		case ReadyEatChess:
            if ([self oppChess:currentPoint]) {
                if([self replaceChess:currentPoint])
                {
                    [self unmarkChess];
                    if ([self diskFull]) {
                        if ([self removeCoverChess]) {
                            _gameState=MoveChess;
                            _whoGo=BLACK;
                        }
                    }else {
                        _gameState=PositionChess;
                        _whoGo=!_whoGo;
                    }
                    
                }
            }
			break;
		case MoveChess:  
            if (![self emptyNode:currentPoint]) {
                if ([self canMovedoutNode:currentPoint]) {
                    [self zoomChess:currentPoint size:1.5];
                    _prePoint=currentPoint;
                }
            }else{  //
                if ([self canMovedinNode:currentPoint]) {
                    [[self nodeFromPoint:_prePoint] removeFromParentAndCleanup:YES];
                    [self goChess:currentPoint];
                    if ([self lineThree:currentPoint]) {
                        [self markChess];
                        _gameState=SelectChess;
                    }
                    _whoGo=!_whoGo;
                }
            }
			break;
        case SelectChess:
            if ([self eatChess:currentPoint]) {
                _gameState=MoveChess;
            }
			break;
        case EndGame:
            for( CCSprite *sprite in [self children] ){
                if( [sprite tag] <= 0 ) continue;
                
                if( CGRectContainsPoint([sprite boundingBox], [self convertTouchToNodeSpace:touch]) ){
                    if ( [sprite tag] ==TAG_MENU_AGAIN) {
                        _whoGo=RED;
                        _gameState=PositionChess;
                        [_disk removeAllChildrenWithCleanup:YES];
                        [self removeChildByTag:TAG_MENU cleanup:YES];
                        [self removeChildByTag:TAG_MENU_AGAIN cleanup:YES];
                        [self scheduleUpdate];
                    }
                }
                
            }
			break;
		default:
			break;
	}

}

@end