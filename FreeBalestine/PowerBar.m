//
//  PowerBar.m
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "PowerBar.h"

@implementation PowerBar

// TODO: find an appropriate sprite for the power bar.
-(id) init {
    if (self = [super init]) {
        self.maskNode = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(300, 20)];
        SKSpriteNode * sprite = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(300, 20)];
        [self addChild:sprite];
        
        self.isBlinking = NO;
    }
    
    return self;
}

-(void) setPower:(CGFloat)power {
    self.maskNode.xScale = power;
}

-(CGFloat) getPower {
    return self.maskNode.xScale;
}

@end
