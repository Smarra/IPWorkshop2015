//
//  GameScene.h
//  ZombieApocalypse
//

//  Copyright (c) 2015 Smara. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property SKNode *foreground;
@property SKNode *background;

@property SKSpriteNode *character;
@property SKSpriteNode *spriteBackground_1;
@property SKSpriteNode *spriteBackground_2;
@property SKLabelNode *scorePoints;
@property SKSpriteNode *Shape1;
@property SKSpriteNode *Shape2;
@property SKSpriteNode *Shape3;
@property SKSpriteNode *Shape4;


-(void)addMonster;
- (void)playerCollision:(SKSpriteNode *)player didCollideWithMonster:(SKSpriteNode *)monster;

@end

@interface GameScene() <SKPhysicsContactDelegate>

@end
