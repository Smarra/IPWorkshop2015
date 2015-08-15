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

@property SKTextureAtlas *atlasBackground;
@property SKTextureAtlas *atlasExplosion;
@property SKSpriteNode *character;
@property SKSpriteNode *spriteBackground;
@property SKSpriteNode *board;
@property SKLabelNode *scorePoints;
@property SKSpriteNode *Shape1;
@property SKSpriteNode *Shape2;
@property SKSpriteNode *Shape3;
@property SKSpriteNode *Shape4;
@property NSMutableArray *texturiMonster;
@property NSMutableArray *texturiCharacter;
@property NSMutableString *myString;
@property SKLabelNode *myLabel;
@property SKLabelNode *myScore;
@property SKSpriteNode *myRestart;
@property NSMutableArray *texturiExplozie;
@property SKAction *animationAction;
@property BOOL retry ;

@property SKSpriteNode *piulita1;
@property SKSpriteNode *piulita2;
@property SKSpriteNode *piulita3;
@property SKSpriteNode *piulita4;
@property SKSpriteNode *piulita5;


-(void)addMonster:(NSInteger)direction withSpeed: (NSInteger)speed;
-(void)changeTextureCharacter;
- (void)playerCollision:(SKSpriteNode *)player didCollideWithMonster:(SKSpriteNode *)monster;

@end

@interface GameScene() <SKPhysicsContactDelegate>

@end
