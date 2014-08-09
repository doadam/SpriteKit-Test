//
//  SignTarget.h
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SignTarget : SKSpriteNode

// A bool property which indicates whether this sign is an arab sign (isRedSign == YES) or an israeli sign (isRedSign == NO).
@property BOOL isRedSign;

+(id) initWithRedColor:(BOOL)red;

-(id) init;

@property BOOL isSignOnScreen;

@end
