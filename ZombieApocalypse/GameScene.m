//
//  GameScene.m
//  ZombieApocalypse
//
//  Created by Smara on 10/08/15.
//  Copyright (c) 2015 Smara. All rights reserved.
//

#import "GameScene.h"
#import <SpriteKit/SpriteKit.h>

@implementation GameScene
int directie = 2;
int increment = 0;
int divided = 150;
int incrementAux=0;
int pozX;
int Bulletproofs = 5;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    
    //Aici cream backgroundul si foregroundul si le setam dimensiunea, posizita, anchorpointul si textura
    _foreground = [[SKNode alloc] init];
    _background = [[SKNode alloc] init];
    
    [_background setPosition:CGPointMake( 0 , 0 )];
    [_foreground setPosition:CGPointMake( 0 , 0 )];
    
    SKTextureAtlas *atlasBackground = [SKTextureAtlas atlasNamed:@"fundal"];
    _spriteBackground_1 = [SKSpriteNode spriteNodeWithTexture:[atlasBackground textureNamed:@"city.png"]];
    _spriteBackground_2 = [SKSpriteNode spriteNodeWithTexture:[atlasBackground textureNamed:@"city.png"]];
    
    [_spriteBackground_1 setAnchorPoint: CGPointMake( 0 , 0)];
    [_spriteBackground_2 setAnchorPoint: CGPointMake( 0 , 0)];
    [_spriteBackground_1 setPosition: CGPointMake(0, 0)];
    [_spriteBackground_2 setPosition: CGPointMake(0, 0)];
    
    
   //Aici cream caracterul si ii setam anchorpointul, pozitia si fizica
    
    _character = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    [_character setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_character setPosition:CGPointMake( self.frame.size.width/2, self.frame.size.height * 0.15)];
    
//    _character.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_character.size];
//    _character.physicsBody.dynamic = YES;
//    _character.physicsBody.categoryBitMask = characterCategory;
//    _character.physicsBody.contactTestBitMask = monsterCategory;
//    _character.physicsBody.collisionBitMask = 0;
//    _character.physicsBody.usesPreciseCollisionDetection = YES;
//    _character.physicsBody.affectedByGravity = NO;
    
    [_character setZPosition:1];
    
    //
    
    [_foreground addChild:_character];
    [_background addChild:_spriteBackground_1];
    [_background addChild:_spriteBackground_2];
    
//    [self addChild:_background];
    [self addChild:_foreground];

    
    //Adaugam scorul
    _scorePoints = [[SKLabelNode alloc] init];
    _scorePoints.fontName = @"Arial";
    _scorePoints.text = @"Bulletproofs: 5";
    _scorePoints.fontSize = 15;
    _scorePoints.fontColor = [SKColor redColor];
    _scorePoints.position = CGPointMake(self.frame.size.width * 0.65, self.frame.size.height*0.97);
    
    [self addChild:_scorePoints];
    
    //adaugam simbolurile ce trebuie apasate
    _Shape1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(32, 32)];
    _Shape2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(32, 32)];
    _Shape3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(32, 32)];
    _Shape4 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size: CGSizeMake(32, 32)];
    
    [_Shape1 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_Shape2 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_Shape3 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_Shape4 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    
    _Shape1.position = CGPointMake(self.frame.size.width *0.35, self.frame.size.height *0.05);
    _Shape2.position = CGPointMake(self.frame.size.width *0.45, self.frame.size.height *0.05);
    _Shape3.position = CGPointMake(self.frame.size.width *0.55, self.frame.size.height *0.05);
    _Shape4.position = CGPointMake(self.frame.size.width *0.65, self.frame.size.height *0.05);
    
    [self addChild:_Shape1];
    [self addChild:_Shape2];
    [self addChild:_Shape3];
    [self addChild:_Shape4];
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if( location.x > 185 && directie<4)
    {
        if(directie == 0)
            [_character runAction:[SKAction moveToX:0.42f * self.frame.size.width duration:0.2]];
        if(directie == 1)
            [_character runAction:[SKAction moveToX:0.5f * self.frame.size.width duration:0.2]];
        if(directie == 2)
            [_character runAction:[SKAction moveToX:0.58f * self.frame.size.width duration:0.2]];
        if(directie == 3)
            [_character runAction:[SKAction moveToX:0.66f * self.frame.size.width duration:0.2]];
        directie++;
    }
    else if(location.x <= 185 && directie>0)
    {
        if(directie == 1)
            [_character runAction:[SKAction moveToX:0.34f * self.frame.size.width duration:0.2]];
        if(directie == 2)
            [_character runAction:[SKAction moveToX:0.42f * self.frame.size.width duration:0.2]];
        if(directie == 3)
            [_character runAction:[SKAction moveToX:0.5f * self.frame.size.width duration:0.2]];
        if(directie == 4)
            [_character runAction:[SKAction moveToX:0.58f * self.frame.size.width duration:0.2]];

        directie--;
    }
    
}

-(void)addMonster{
    // Create sprite
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
    monster.name = @"nameMonster";
    monster.anchorPoint = CGPointMake(0.5f, 0.5f);
    monster.position = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    //Determine speed of the monster
//    int minDuration = 2.0;
//    int maxDuration = 4.0;
//    int rangeDuration = maxDuration - minDuration;
//    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    //Create actions
    SKAction *actionMove = [SKAction moveToY:120 duration:2];
    [monster runAction:actionMove];
    
//    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
//    monster.physicsBody.dynamic = YES;
//    monster.physicsBody.categoryBitMask = monsterCategory;
//    monster.physicsBody.contactTestBitMask = characterCategory;
//    monster.physicsBody.collisionBitMask = 0;
    
    
    // Determine where to spawn the monster along the Y axis
    int lane = rand() % 5;
    
    switch (lane) {
        case 0:
            pozX = 0.34f * self.frame.size.width;
            break;
            
        case 1:
            pozX = 0.42f * self.frame.size.width;
            break;
            
        case 2:
            pozX = 0.5f * self.frame.size.width;
            break;
            
        case 3:
            pozX = 0.58f * self.frame.size.width;
            break;
            
        case 4:
            pozX = 0.66f * self.frame.size.width;
            break;
    }
    
    monster.position = CGPointMake(pozX, self.frame.size.height);
    [self addChild:monster];
}

//- (void)playerCollision:(SKSpriteNode *)player didCollideWithMonster:(SKSpriteNode *)monster {
//    NSLog(@"Hit");
//    [_character removeFromParent];
//    [monster removeFromParent];
//}
//
//- (void)didBeginContact:(SKPhysicsContact *)contact
//{
//    // 1
//    SKPhysicsBody *firstBody, *secondBody;
//    
//    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
//    {
//        firstBody = contact.bodyA;
//        secondBody = contact.bodyB;
//    }
//    else
//    {
//        firstBody = contact.bodyB;
//        secondBody = contact.bodyA;
//    }
//    
//    // 2
//    if ((firstBody.categoryBitMask & characterCategory) != 0 &&
//        (secondBody.categoryBitMask & monsterCategory) != 0)
//    {
//        [self playerCollision:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
//    }
//}

//- (void)enumerateChildNodesWithName:(NSString *)name usingBlock:(void (^)(SKNode *node, BOOL *stop))block{
//    
//}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self enumerateChildNodesWithName:@"nameMonster" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if ( node.position.y  <= 150 && Bulletproofs>0)
        {
            Bulletproofs --;
            NSLog(@"%d\n", Bulletproofs);
            [node removeFromParent];

            _scorePoints.text = [NSString stringWithFormat:@"Bulletproofs: %d",Bulletproofs];
        }
        
        if(Bulletproofs <=0)
        {
            [node removeFromParent];
            _scorePoints.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2);
            _scorePoints.text = @"GAME OVER";
        }
    }];
    
    //Numarul de monstrii creste la fiecare 300 de frameuri
    if(divided >=60 && incrementAux % 300 == 0 && Bulletproofs>0)
    {
        incrementAux = 0;
        divided-=10;
    }
    incrementAux++;
    
    if(increment % divided == 0 && Bulletproofs>0)
    {
        [self addMonster];
        increment = 0;
        
    }
    increment++;
    
}

@end
