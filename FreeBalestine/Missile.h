//
//  Missile.h
//  FreeBalestine
//
//  Created by Adam on 8/11/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Missile : SKSpriteNode

-(id) initForFrame:(SKNode*)parent atPosition:(CGPoint)position;

-(void) fireWithForce:(CGVector)force;

-(void) updateRotation;

@end
