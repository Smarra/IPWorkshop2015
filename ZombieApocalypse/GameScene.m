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
    _character.name= @"nameCharacter";
    
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

//    NSString *sir = @"123";
//    NSMutableString *NewString = [[NSMutableString alloc] init];
//    
//    [NewString appendString:sir];
//    [NewString appendString:@"4"];
//    
//    NSLog(@"%@",NewString);

    
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
    
    _Shape1.name = @"nameShape1";
    _Shape2.name = @"nameShape2";
    _Shape3.name = @"nameShape3";
    _Shape4.name = @"nameShape4";
    
    [self addChild:_Shape1];
    [self addChild:_Shape2];
    [self addChild:_Shape3];
    [self addChild:_Shape4];
    
    
    //modificam myLabel si myString
    _myString = [[NSMutableString alloc] init];
    _myLabel = [[SKLabelNode alloc] init];
    _myLabel.fontColor = [SKColor greenColor];
    _myLabel.fontSize = 12;
    _myLabel.fontName = @"Chalkduster";
    _myLabel.position = CGPointMake(self.frame.size.width * 0.6, self.frame.size.height * 0.93);
    [self addChild: _myLabel];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    [self enumerateChildNodesWithName:@"nameShape1" usingBlock:^(SKNode *  node, BOOL * stop) {
        
        if( (SKSpriteNode *)node == (SKSpriteNode *)[self nodeAtPoint:location] )
        {
            NSLog(@"YASSS");
            [_myString appendString:[NSMutableString stringWithFormat:@"%d", 1]];
            _myLabel.text = [NSMutableString stringWithFormat:@"%@", _myString ];
            NSLog(@"%@ %@", _myString, _myLabel.text);
        }
    }];
    
    [self enumerateChildNodesWithName:@"nameShape2" usingBlock:^(SKNode *  node, BOOL * stop) {
        
        if( (SKSpriteNode *)node == (SKSpriteNode *)[self nodeAtPoint:location] )
        {
            [_myString appendString:[NSMutableString stringWithFormat:@"%d", 2]];
            _myLabel.text = [NSMutableString stringWithFormat:@"%@", _myString ];
        }
    }];
    
    [self enumerateChildNodesWithName:@"nameShape3" usingBlock:^(SKNode *  node, BOOL * stop) {
        
        if( (SKSpriteNode *)node == (SKSpriteNode *)[self nodeAtPoint:location] )
        {
            [_myString appendString:[NSMutableString stringWithFormat:@"%d", 3]];
            _myLabel.text = [NSMutableString stringWithFormat:@"%@", _myString ];
        }
    }];
    
    [self enumerateChildNodesWithName:@"nameShape4" usingBlock:^(SKNode *  node, BOOL * stop) {
        
        if( (SKSpriteNode *)node == (SKSpriteNode *)[self nodeAtPoint:location] )
        {
            [_myString appendString:[NSMutableString stringWithFormat:@"%d", 4]];
            _myLabel.text = [NSMutableString stringWithFormat:@"%@", _myString ];
        }
    }];
    
    UITouch *touch1 = [touches anyObject];
    CGPoint location1 = [touch1 locationInView:self.view];
    
    if(location1.y < self.view.frame.size.height * 0.92)
    if( location1.x > self.view.frame.size.width/2 && directie<4)
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
    else if(location1.x <= self.view.frame.size.width/2 && directie>0)
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
    monster.anchorPoint = CGPointMake(0.5f, 1.f);
    monster.position = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    //Create actions
    SKAction *actionMove = [SKAction moveToY:120 duration:10];
    [monster runAction:actionMove];
    
    
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
    
    //Adaugam cheia dupa care cauta, linia pe care se afla monstrul
    monster.userData = [[NSMutableDictionary alloc] init];
    [monster.userData setValue: [NSString stringWithFormat:@"%d", lane] forKey:@"Nr_linie"];
    
    //Cream labelul monsterului
    SKLabelNode *monsterLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    monsterLabel.fontSize = 20;
    monsterLabel.name = @"nameLabel";
    
    int numarDeCuvinte = 3+ (arc4random()%9998 + arc4random()%3421)%5;
    
    NSMutableString *aux = [[NSMutableString alloc] init];
    for(int i=1; i<=numarDeCuvinte; i++)
    {
        [aux appendString:[NSMutableString stringWithFormat:@"%d", 1+(arc4random()%9998 + arc4random()%3421)%4]];
    }
    
    monsterLabel.text = aux;
    
    [monster addChild:monsterLabel];
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
//            Bulletproofs --;
            NSLog(@"%d\n", Bulletproofs);
            [node removeFromParent];

            _scorePoints.text = [NSString stringWithFormat:@"Bulletproofs: %d",Bulletproofs];
        }
        
        [node enumerateChildNodesWithName:@"nameLabel" usingBlock:^(SKNode * _Nonnull copil, BOOL * _Nonnull stop) {
            if ( copil != nil)
            {
                SKLabelNode *aux = (SKLabelNode *)copil;
                if([node.userData valueForKey:@"Nr_linie"] == [NSString stringWithFormat:@"%d",directie])
                {
                    NSLog(@"%@ %@ %@",aux.text, _myLabel.text, _myString);
                    NSMutableString *auxString = [[NSMutableString alloc] init];
                    if([_myLabel.text isEqualToString:aux.text])
                    {
                        NSLog(@"YAS");
                        [node removeFromParent];
                        _myString = [NSMutableString stringWithFormat:@"%@", auxString];
                        _myLabel.text = [NSString stringWithFormat:@"%@", auxString];
                    }
                    else if(_myLabel.text.length >= aux.text.length)
                    {
                        _myString = [NSMutableString stringWithFormat:@"%@", auxString];
                        _myLabel.text = [NSString stringWithFormat:@"%@", auxString];
                    }
                }
        
            }
        }];
        
        if(Bulletproofs <=0)
        {
            [node removeFromParent];
            _scorePoints.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2);
            _scorePoints.text = @"GAME OVER";
        }
        
    }];
    
    //Schimbam myLabel
    
    //Numarul de monstrii creste la fiecare 300 de frameuri
    if(divided >=90 && incrementAux % 400 == 0 && Bulletproofs>0)
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
