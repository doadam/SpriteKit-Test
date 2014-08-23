//
//  SignTarget.m
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "SignTarget.h"
#import "Common.h"

static const NSTimeInterval TIME_FOR_SIGN_TO_LIVE = 3.0f;
static const NSTimeInterval TIME_FOR_SIGN_APPEARANCE = 0.3f;


@implementation SignTarget

+(id) initWithRedColor:(BOOL)red {
    // Generate a random name
    
    NSString * signName;
    
    // TODO: there must be a way to create a pointer to the const array of pointers but I can't find the appropriate syntax
    //       because objective-c is and xcode are weird!
    
    if(red) {
        NSUInteger randomNameIndex = arc4random() % (sizeof(RED_SIGN_NAMES) / sizeof(RED_SIGN_NAMES[0]));
        signName = RED_SIGN_NAMES[randomNameIndex];
    }
    else {
        NSUInteger randomNameIndex = arc4random() % (sizeof(GREEN_SIGN_NAMES) / sizeof(GREEN_SIGN_NAMES[0]));
        signName = GREEN_SIGN_NAMES[randomNameIndex];
    }
    
    SignTarget * sign = [[SignTarget alloc] initWithSignName:signName];
    sign.isRedSign = red;
    
    return sign;
}

-(id) initWithSignName:(NSString*)signName {
    
    if(self = [super initWithImageNamed:signName]) {
        self.isSignOnScreen = YES;
        [self setScale:SIGN_SCALE];
        [self setYScale:0];
        
        if (!CGSizeEqualToSize(defaultSize, [self size])) {
            defaultSize = [self size];
        }
        
        SKPhysicsBody * body = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        body.affectedByGravity = NO;
        body.contactTestBitMask |= CATEGORY_MISSILE;
        body.categoryBitMask = CATEGORY_SIGN;
        body.collisionBitMask = 0;
        self.physicsBody = body;
        
        SKAction * appearAction = [SKAction scaleYTo:SIGN_SCALE duration:TIME_FOR_SIGN_APPEARANCE];
        SKAction * delayBetweenDisappear = [SKAction waitForDuration:TIME_FOR_SIGN_TO_LIVE];
        SKAction * disappearAction = [SKAction scaleYTo:0.0f duration:TIME_FOR_SIGN_APPEARANCE];
        
        // Nothing about hitting is done here, because in case of contact, we will remove all the actions immediately.
        [self runAction:[SKAction sequence:@[appearAction, delayBetweenDisappear, disappearAction]] completion:^{
            // When finishing, mark sign for cleanup.
            // TODO: remove it, we can use the normal API for it.
            self.isSignOnScreen = NO;
        }];
    }
    
    // A check is not performed here because either way we will return null or a valid object.
    return self;
}


@end
