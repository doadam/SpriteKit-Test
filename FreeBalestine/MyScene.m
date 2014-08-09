//
//  MyScene.m
//  FreeBalestine
//
//  Created by Adam on 8/8/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "MyScene.h"
#import "SignTarget.h"
#import "PowerBar.h"

static const NSUInteger POWER_BAR_TIMER = 0.5f;

@interface MyScene()

@property PowerBar * powerBar;

@property CFTimeInterval decreasePowerBarTimer;

@property CFTimeInterval increasePowerBarTimer;

@property CFTimeInterval lastRecord;

//TODO: maybe there's an implementation for it, it's so stupid I have to take care of this!
@property BOOL isTouching;

// Called when releasing the touch (firing). handles power bar graphics and stuff.
-(void) onPowerBarRelease;

@end

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
        
        
        self.isTouching = NO;
        
        
        self.signs = [NSMutableSet setWithCapacity:MAX_NUMBER_OF_SIGNS_ON_THE_SCREEN];
        
        // Create the power bar here
        self.powerBar = [[PowerBar alloc] init];
        self.powerBar.position = CGPointMake(0, 0);
        self.decreasePowerBarTimer = POWER_BAR_TIMER;
        self.increasePowerBarTimer = POWER_BAR_TIMER;
        
        [self.powerBar setPower:0.0f];
        
        [self addChild:self.powerBar];
        
        // Initialize counter here
        
        
        // first spawn time is calculated right when the scene is initialized
        self.lastSpawnTime = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    return self;
}

-(void) onPowerBarRelease {
    self.powerBar.isBlinking = YES;
    
    // Make powerbar blinking
    // TODO: constify
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.05f],
                                           [SKAction fadeInWithDuration:0.05f]]];
    [self.powerBar runAction:[SKAction repeatAction:blink count:4] completion:^{
        self.powerBar.isBlinking = NO;
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.isTouching = NO;
    
    [self onPowerBarRelease];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    self.isTouching = YES;
    
    /*
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
     
     */
}

-(void) addSign {
    // TODO: make it a bit less abitrary
    SignTarget * sign = [SignTarget initWithRedColor:(arc4random() % 3 == 0)];
    
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
        [self.powerBar setPower:([self.powerBar getPower] + 0.1f)];
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

-(void) handlePowerBar:(CFTimeInterval)diff {

    // When we're about to fire, don't mess with the Power Bar!
    if([self.powerBar isBlinking]) {
        return;
    }
    
    if(!self.isTouching) {
        
        // Decrease power bar
        if(self.decreasePowerBarTimer < diff) {
            self.decreasePowerBarTimer = POWER_BAR_TIMER;
            CGFloat currentPowerBarValue = [self.powerBar getPower];
            if(currentPowerBarValue > 0) {
                
                //TODO: make a const for it
                [self.powerBar setPower:currentPowerBarValue-0.05f];
            }
        }
        else {
            self.decreasePowerBarTimer -= diff;
        }
    }
    
    else {
        
        // Increase power bar
        if(self.increasePowerBarTimer < diff) {
            self.increasePowerBarTimer = POWER_BAR_TIMER;
            CGFloat currentPowerBarValue = [self.powerBar getPower];
            if(currentPowerBarValue < 1.0f) {
                
                //TODO: make a const for it
                [self.powerBar setPower:currentPowerBarValue+0.05f];
            }
        }
        else {
            self.increasePowerBarTimer -= diff;
        }
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

    if(0 == self.lastRecord) {
        self.lastRecord = currentTime;
    }
    
    CFTimeInterval diff = currentTime - self.lastRecord;
    self.lastRecord = currentTime;
    // Make sure there are enough signs on the screen
    [self validateNumberOfSigns];
    
    // Power bar timer.
    [self handlePowerBar:diff];
    
    
    
    [self cleanupRemovedSigns];
    
}


// Collision detection
- (void)didBeginContact:(SKPhysicsContact *)contact {
    
}

@end
