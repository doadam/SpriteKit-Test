//
//  MyScene.m
//  FreeBalestine
//
//  Created by Adam on 8/8/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "MyScene.h"
#import "SignTarget.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // Set the physics contact delegate as this class. (didBegin\EndContact is implemented)
        self.physicsWorld.contactDelegate = self;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        
        self.signs = [NSMutableSet setWithCapacity:MAX_NUMBER_OF_SIGNS_ON_THE_SCREEN];
        
        // Initialize counter here
        
        
        // first spawn time is calculated right when the scene is initialized
        self.lastSpawnTime = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void) addSign {
    // TODO: make it a bit less abitrary
    SignTarget * sign = [SignTarget initWithRedColor:(arc4random() % 3 != 0)];
    
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat randomXPosiiton = fmod(arc4random(), screenSize.width);
    CGFloat randomYPosiiton = fmod(arc4random(), screenSize.height);
    
    // Calculate random position on the screen
    CGPoint signPoint = CGPointMake(randomXPosiiton, randomYPosiiton);
    
    sign.position = signPoint;
    
    [self.signs addObject:sign];
    
    // Finally add it to the screen
    [self addChild:sign];
    
}

-(NSUInteger) calculateNumberOfSignsNeededOnScreen {
    
    NSDate * now = [NSDate dateWithTimeIntervalSinceNow:0];
    
    // The formula is, each 5 seconds add an additional sign.
    
    NSTimeInterval timeSinceLastSpawn = [now timeIntervalSinceDate:self.lastSpawnTime];
    
    if((timeSinceLastSpawn / SECONDS_FOR_ADDING_SIGN) >= 1) {
         self.lastSpawnTime = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    
    return timeSinceLastSpawn / SECONDS_FOR_ADDING_SIGN;
}

-(void)validateNumberOfSigns {
    
    NSUInteger numberOfSignsOnScreen = self.signs.count;
    NSUInteger numberOfSignsNeededOnScreen = [self calculateNumberOfSignsNeededOnScreen];
    
    for(; numberOfSignsOnScreen < numberOfSignsNeededOnScreen; ++numberOfSignsOnScreen) {
        [self addSign];
    }
}

-(void)updateCountersWithNumberOfKills:(NSUInteger)numberOfKills livesLeft:(NSUInteger)numberOfLivesLeft {
    self.counters.text = [NSString stringWithFormat:COUNTER_FORMAT, (unsigned int)self.numberOfGreenAttackedSigns, 0];
}

-(void)cleanupRemovedSigns {
    
    if(!self.signs.count) {
        return;
    }
    
    NSMutableSet * signsToRemove = [NSMutableSet setWithCapacity:self.signs.count];
    
    for(SignTarget * sign in self.signs) {
        if(!sign.isSignOnScreen) {
            [sign removeFromParent];
            [signsToRemove addObject:sign];
        }
    }
    
    for(NSMutableSet * signToRemove in signsToRemove) {
        [self.signs removeObject:signToRemove];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    // Make sure there are enough signs on the screen
    [self validateNumberOfSigns];
    
    [self cleanupRemovedSigns];
    
}


// Collision detection
- (void)didBeginContact:(SKPhysicsContact *)contact {
    
}

@end
