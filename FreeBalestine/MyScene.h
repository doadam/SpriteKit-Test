//
//  MyScene.h
//  FreeBalestine
//

//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static const NSUInteger SECONDS_FOR_ADDING_SIGN = 5;

static const NSUInteger MAX_NUMBER_OF_SIGNS_ON_THE_SCREEN = 10;

static NSString * const COUNTER_FORMAT = @"Kills: %ul. Lives: %ul";

static const CGFloat MUHAMMAD_LABEL_ALPHA_ON_HIT = 0.2f;

static const CGFloat MUHAMMAD_LABEL_ALPHA_ON_MISS = -0.05f;

@interface MyScene : SKScene <SKPhysicsContactDelegate>


@end
