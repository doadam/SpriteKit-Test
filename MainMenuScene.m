//
//  MainMenuScene.m
//  FreeBalestine
//
//  Created by Adam on 8/23/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

#import "MainMenuScene.h"
#import "MyScene.h"
#import "Common.h"

@import AVFoundation;

@interface MainMenuScene()

@property SKLabelNode * startGameLabel;

@property SKLabelNode * aboutGameLabel;

@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

-(void)playBackgroundMusic;

-(void)createADancingMusa;

@end

@implementation MainMenuScene

-(void)playBackgroundMusic {
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"startmusic" withExtension:@"caf"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}

-(void)createADancingMusa {
    
    // Create the Musa node.
    SKSpriteNode * musa = [SKSpriteNode spriteNodeWithImageNamed:@"musa"];
    [musa setScale:MUSA_SCALE];
    [self addChild:musa];
    
    
    // TODO: perhaps make more functions to do it, maybe constify, who cares.
    CGPoint position = CGPointMake(self.size.width/2, self.size.height/4);
    
    SKAction * waitAction = [SKAction waitForDuration:0.87*15.8f];
    
    CGMutablePathRef arcPath = CGPathCreateMutable();
    CGPathAddArc(arcPath, NULL, position.x, position.y, 80.0f, 0, 3.0f, NO);
    SKAction * followPath1 = [SKAction followPath:arcPath asOffset:NO orientToPath:NO duration:0.87f];
    
    // Set Musa in the starting position.
    [musa setPosition:position];
    
    arcPath = CGPathCreateMutable();
    CGPathAddArc(arcPath, NULL, position.x, position.y, 80.0f, 3.0f, 0.0f, YES);
    SKAction * followPath2 = [SKAction followPath:arcPath asOffset:NO orientToPath:NO duration:0.87f];
    
    [musa runAction:[SKAction sequence:@[waitAction,[SKAction repeatActionForever:[SKAction sequence:@[followPath1, followPath2]]]]]];
}


-(id)initWithSize:(CGSize)size {
    
    if(self = [super initWithSize:size]) {
        
        // Create background.
        SKSpriteNode * backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"PalestineFlag.png"];
        
        // Size it and locate it appropriately.
        backgroundImage.position = CGPointMake(size.width/2, size.height/2);
        backgroundImage.size = CGSizeMake(size.height, size.width);
        backgroundImage.zRotation = atan2f(1.0f, 0.0f);
        
        [self addChild:backgroundImage];
        
        
        // Create labels
        
        self.startGameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.startGameLabel.position = CGPointMake(size.width/2, size.height*0.75f);
        self.startGameLabel.text = @"Start Game";
        self.startGameLabel.fontColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.5f alpha:1.0f];
        
        [self addChild:self.startGameLabel];
        
        self.aboutGameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.aboutGameLabel.position = CGPointMake(size.width/2, size.height/2);
        self.aboutGameLabel.text = @"About FreeBalestine";
        self.aboutGameLabel.fontSize = 20.0f;
        self.aboutGameLabel.fontColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.5f alpha:1.0f];
        
        [self addChild:self.aboutGameLabel];
        
        // Play background music.
        [self playBackgroundMusic];
        
        // Make a dancing Musa, giving joy to the world.
        [self createADancingMusa];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint position = [touch locationInNode:self];
    
    SKNode * nodeTouched = [self nodeAtPoint:position];
    
    
    if(nodeTouched == self.startGameLabel) {
        // Transition
        SKTransition * transitionToGame = [SKTransition fadeWithDuration:2.0f];
        SKScene * gameScene = [MyScene sceneWithSize:self.size];
        
        [self.view presentScene:gameScene transition:transitionToGame];
    }
    else if(nodeTouched == self.aboutGameLabel) {
        // About transition
    }
    
}

@end
