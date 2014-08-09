//
//  MyScene.h
//  FreeBalestine
//

//  Copyright (c) 2014 Adam. All rights reserved.
//

static const NSUInteger MAX_NUMBER_OF_SIGNS_ON_THE_SCREEN = 10;

static NSString * const COUNTER_FORMAT = @"Kills: %ul. Lives: %ul";

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>

// Indicates whether Hummus has been eaten (if YES, then all the signs are green).
@property BOOL hasEatenHummus;

// The number of green attacked signs.
@property NSUInteger numberOfGreenAttackedSigns;

// The number of red attacked signs.
@property NSUInteger numberOfRedAttackedSigns;

// Signs of Arabs
@property NSArray * redSigns;

// Signs of Israelis
@property NSArray * greenSigns;

@property SKLabelNode * counters;

// Makes sure that there are enough signs on the game map.
-(void) validateNumberOfSigns;

-(void) updateCountersWithNumberOfKills:(NSUInteger)numberOfKills livesLeft:(NSUInteger)numberOfLivesLeft;

@end
