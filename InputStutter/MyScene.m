//
//  MyScene.m
//  InputStutter
//
//  Created by Justin Warkentin on 4/3/14.
//  Copyright (c) 2014 bugreport. All rights reserved.
//

#import "MyScene.h"

@interface MyScene()

@property (nonatomic) SKSpriteNode *player;

@end

@implementation MyScene

-(void) addPlayer:(CGSize)size {
    //player node
    self.player = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(64, 64)];
    //player line node
    SKSpriteNode *playerLine = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(4, 1136)];
    
    //position
    self.player.position = CGPointMake(32, self.player.size.height);
    
    //add to scene
    [self addChild:self.player];
    [self.player addChild:playerLine];
    
    
}


- (void)addSquare:(CGSize)size {
    //square node
    SKSpriteNode *square = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(64, 64)];
    square.position = CGPointMake(32, size.height - square.size.height);
    //square line node
    SKSpriteNode *squareLine = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(4, 1136)];
    
    [self addChild:square];
    [square addChild:squareLine];
    
    //actions
    SKAction *right = [SKAction moveByX:(size.width - square.size.width) y:0 duration:1];
    SKAction *left = [right reversedAction];
    
    //sequence
    SKAction *rightAndLeft = [SKAction sequence:@[right,left]];
    SKAction *repeater = [SKAction repeatActionForever:rightAndLeft];
    
    //repeat
    [square runAction:repeater];
}

//update position as long as screen is being touched
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint newPosition = CGPointMake(location.x, self.player.size.height);
        
        if (newPosition.x < self.player.size.width/2) {
            newPosition.x = self.player.size.width/2;
        }
        if (newPosition.x > self.size.width - (self.player.size.width/2)) {
            newPosition.x = self.size.width - (self.player.size.width/2);
        }
        
        self.player.position = newPosition; //put after screen fix, so the postion updates correctly
        
    }
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        [self addSquare:size];
        [self addPlayer:size];
        
        int width = self.size.width;
        int height = self.size.height;
        
        NSLog(@"width = %i and height = %i", width, height);
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
