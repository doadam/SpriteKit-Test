//
//  Missile.m
//  FreeBalestine
//
//  Created by Adam on 8/11/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "Missile.h"
#import "Common.h"

// TODO: maybe create a better PNGs? don't really give a damn about it
static const CGFloat SCALE_MODIFIER = 0.25f;

static const CGFloat BODY_MASS = 0.5f;

static const CGFloat TAIL_X_POINT = 0;

static const CGFloat TAIL_Y_POINT = -180.0f;

@interface Missile()

-(SKEmitterNode*) createTailWithTargetNode:(SKNode*)targetNode;

@end

@implementation Missile

-(SKEmitterNode*) createTailWithTargetNode:(SKNode *)targetNode{
    
    NSString *rocketTailString = [[NSBundle mainBundle] pathForResource:@"RocketTail" ofType:@"sks"];
    SKEmitterNode * rocketTail = [NSKeyedUnarchiver unarchiveObjectWithFile:rocketTailString];
    
    // We could pass the point as a parameter, but we don't need more than a single tail.
    rocketTail.position = CGPointMake(TAIL_X_POINT, TAIL_Y_POINT);
    rocketTail.targetNode = targetNode;
    
    
    return rocketTail;
}

-(id) initForFrame:(SKNode *)parent atPosition:(CGPoint)position{
    
    if (self = [super initWithImageNamed:@"Spaceship"]) {
        
        [self setScale:SCALE_MODIFIER];
        [self setPosition:position];
        SKPhysicsBody * body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        
        body.contactTestBitMask |= CATEGORY_SIGN;
        body.categoryBitMask = CATEGORY_MISSILE;
        body.collisionBitMask = 0;
        body.mass = BODY_MASS;
        body.allowsRotation = YES;
        
        body.dynamic = YES;
        self.physicsBody = body;
        
        // TODO: fix missile power, just change some stats and upload the new sks to the phone.
        //SKEmitterNode * rocketTail = [self createTailWithTargetNode:parent];
        
        //[self addChild:rocketTail];

    }
    
    return self;
}

-(void)fireWithForce:(CGVector)force {
    [self.physicsBody applyImpulse:force];
}

-(void)updateRotation {
    
    CGVector currentVelocity = self.physicsBody.velocity;
    self.zRotation = atan2f(currentVelocity.dx, currentVelocity.dy);
}

@end
