//
//  SignTarget.h
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


// TODO: resize the actual PNG, and don't use this constant.
static const CGFloat SIGN_SCALE = 0.12f;

static NSString * GREEN_SIGN_NAMES[] = {
    @"Ashdod",
    @"Ashkelon",
    @"Be'er-Sheva",
    @"Haifa",
    @"Hertzliya",
    @"Holon",
    @"Netanya",
    @"Sderot",
    @"Shejaiya",
    @"Tel aviv.png"};

static NSString * RED_SIGN_NAMES[] = {
    @"Khan Yunis",
    @"Rafah",
    @"Shejaiya",
    @"Yokneam"
};

@interface SignTarget : SKSpriteNode

// A bool property which indicates whether this sign is an arab sign (isRedSign == YES) or an israeli sign (isRedSign == NO).
@property BOOL isRedSign;

+(id) initWithRedColor:(BOOL)red;

-(id) initWithSignName:(NSString*)signName;

@property BOOL isSignOnScreen;

@end
