//
//  HelloWorldLayer.m
//  Ball Dodge
//
//  Created by Chao Xu on 13-8-8.
//  Copyright Chao Xu 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "GamePlay.h"
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        CCSprite *backGround = [CCSprite spriteWithFile:@"road.jpg"];
        backGround.position = ccp(240,160);
        [self addChild:backGround];
		[CCMenuItemFont setFontName:@"Marker Felt"];
        [CCMenuItemFont setFontSize:35];
        CCMenuItemFont *item1 = [CCMenuItemFont itemWithLabel:[CCLabelBMFont labelWithString:@"Start" fntFile:@"label2.fnt"] target:self selector:@selector(start:)];
        CCMenu *menu = [CCMenu menuWithItems:item1, nil];
        [self addChild:menu];
		
        
	}
	return self;
}
-(void) start: (id)sender{
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:1 scene:[GamePlay node]]];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
