//
//  GamePlay.m
//  Ball Dodge
//
//  Created by Chao Xu on 13-8-8.
//  Copyright (c) 2013年 Chao Xu. All rights reserved.
//

#import "GamePlay.h"
#import "HelloWorldLayer.h"
#import "CDAudioManager.h"
#import "CocosDenshion.h"
#import "SimpleAudioEngine.h"
@implementation GamePlay

enum{
    kTagBall,
    kTagEnemy
};

+(CCScene *) scene{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GamePlay *layer = [GamePlay node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init{
    if ((self = [super init])) {
        self.isTouchEnabled = YES;
       
        
        if ([[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying]) {
            [[SimpleAudioEngine sharedEngine]resumeBackgroundMusic];
        }
        else{
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ALAYLM.mp3"];;
        }
        CCSprite *backGround = [CCSprite spriteWithFile:@"road.jpg"];
        backGround.position = ccp(240,160);
        [self addChild:backGround];
        CCSprite *button = [CCSprite spriteWithFile:@"greenButton.png"];
        button.position = ccp(240,40);
        [self addChild:button z:1 tag:kTagBall];
        CCSprite *enemy = [CCSprite spriteWithFile:@"football.png"];
        enemy.position = ccp(240,280);
        [self addChild:enemy z:2 tag:kTagEnemy];
        [self schedule:@selector(move) interval:.01];
        x=5;
        y=5;
    }
    return self;
}
-(void) move {
    CCNode *enemy = [self getChildByTag:kTagEnemy];
    CCNode *button = [self getChildByTag:kTagBall];
    
    if (enemy.position.x > 480 || enemy.position.x <0) {
        x = -x;
    }
    if (enemy.position.y >320 || enemy.position.y <0) {
        y = -y;
    }
    enemy.position = ccp(enemy.position.x + x,enemy.position.y + y);
    
    float xDif = enemy.position.x - button.position.x;
    float yDif = enemy.position.y - button.position.y;
    float distance = sqrt(xDif * xDif + yDif * yDif);
    if(distance < 44){
        [self unschedule:@selector(move)];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Do it Again" delegate:self cancelButtonTitle:@"Go to Main" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
-(void)alertView:(UIAlertView *) alert clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:1 scene:[HelloWorldLayer node]]];
    }
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *myTouch = [touches anyObject];
    CGPoint point = [myTouch locationInView:[myTouch view]];
    point = [[CCDirector sharedDirector]convertToGL:point];
    
    CCNode *sprite = [self getChildByTag:kTagBall];
    [sprite setPosition:point];
}
@end
