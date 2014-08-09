//
//  SignTarget.m
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "SignTarget.h"


static const NSTimeInterval TIME_FOR_SIGN_TO_LIVE = 3.0f;
static const NSTimeInterval TIME_FOR_SIGN_APPEARANCE = 0.3f;
@implementation SignTarget

+(id) initWithRedColor:(BOOL)red {
    SignTarget * sign = [[SignTarget alloc] init];
    sign.isRedSign = red;
    
    return sign;
}

-(id) init {
    
    if(self = [super initWithImageNamed:@"Spaceship"]) {
        [self setYScale:0];
        SKAction * appearAction = [SKAction scaleYTo:1.0f duration:TIME_FOR_SIGN_APPEARANCE];
        SKAction * delayBetweenDisappear = [SKAction waitForDuration:TIME_FOR_SIGN_TO_LIVE];
        SKAction * disappearAction = [SKAction scaleYTo:0.0f duration:TIME_FOR_SIGN_APPEARANCE];
        
        // Nothing about hitting is done here, because in case of contact, we will remove all the actions immediately.
        [self runAction:[SKAction sequence:@[appearAction, delayBetweenDisappear, disappearAction]] completion:^{
            // When finishing, mark sign for cleanup.
            self.isSignOnScreen = NO;
        }];
    }
    
    // A check is not performed here because either way we will return null or a valid object.
    return self;
}

@end
