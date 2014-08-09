//
//  PowerBar.h
//  FreeBalestine
//
//  Created by Adam on 8/9/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

// TODO: do we really need SKCropNode for this?
@interface PowerBar : SKCropNode

// Updates the graphics for the current throwing power
-(void) setPower:(CGFloat)power;

-(CGFloat) getPower;

// Used when we're about to fire the missile
@property BOOL isBlinking;

@end
