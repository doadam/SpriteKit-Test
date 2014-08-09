//
//  MyScene.h
//  FreeBalestine
//

//  Copyright (c) 2014 Adam. All rights reserved.
//

static const NSUInteger SECONDS_FOR_ADDING_SIGN = 5;

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
@property NSMutableSet * redSigns;

// Signs of Israelis
@property NSMutableSet * greenSigns;

// A label with the current stats
@property SKLabelNode * counters;

// The time when the scene started.
@property NSDate * lastSpawnTime;

// Makes sure that there are enough signs on the game map.
-(void) validateNumberOfSigns;

// Updates counters, just a format thing
-(void) updateCountersWithNumberOfKills:(NSUInteger)numberOfKills livesLeft:(NSUInteger)numberOfLivesLeft;

// Adds a sign to the screen
-(void) addSign;

// Cleans up signs which are supposedly removed from the screen
-(void) cleanupRemovedSigns;

@end
