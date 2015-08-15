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
int increment = 100;
int incrementCuv = 1;
int incrementViteza = 1;
int divided = 150;
int incrementAux=0;
int pozX;
int Bulletproofs = 5;
int numarDeCuvinte = 3;
float viteza = 15.f;
int numarUcideri = 0;

-(void)resetAll
{
    directie = 2;
    increment = 100;
    incrementCuv = 1;
    incrementViteza = 1;
    divided = 150;
    incrementAux=0;
    Bulletproofs = 5;
    numarDeCuvinte = 3;
    viteza = 15.f;
    numarUcideri = 0;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    
    //Aici cream backgroundul si foregroundul si le setam dimensiunea, posizita, anchorpointul si textura
    _foreground = [[SKNode alloc] init];
    _background = [[SKNode alloc] init];
    
    [_background setZPosition:-10];
    [_background setPosition:CGPointMake( 0 , 0 )];
    [_foreground setPosition:CGPointMake( 0 , 0 )];
    
    _atlasBackground = [SKTextureAtlas atlasNamed:@"FundalSprites"];
    _spriteBackground = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"bckgrdFULL.png"]];
    _board = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"board_red.png"]];
    
    [_spriteBackground setAnchorPoint: CGPointMake( 0.5f , 0.5f)];
    [_spriteBackground setPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height*0.55)];
    [_spriteBackground setXScale:1.35]; [_spriteBackground setYScale:1.35];
    [_board setAnchorPoint:CGPointMake(0.5f, 0.f)];
    [_board setPosition: CGPointMake(self.frame.size.width/2, -self.frame.size.height * 0.13)];
    [_board setZPosition:2];
    
    //Aici initializam atlasul de explozie
    _atlasExplosion = [SKTextureAtlas atlasNamed:@"atlasExplozie.atlas"];
    _texturiExplozie = [NSMutableArray array];
    for (int i = 1; i < _atlasExplosion.textureNames.count; i++) {
        [_texturiExplozie addObject:[_atlasExplosion textureNamed:[NSString stringWithFormat:@"explozie%d.png", i]]];
    }
    
    _animationAction = [SKAction animateWithTextures:_texturiExplozie timePerFrame:0.5 / _texturiExplozie.count];
    
    
   //Aici cream caracterul si ii setam anchorpointul, pozitia si fizica
    
    _character = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"bomba_init"]];
    [_character setXScale:0.3]; [_character setYScale:0.3];
    [_character setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_character setPosition:CGPointMake( self.frame.size.width/2, self.frame.size.height * 0.15)];
    _character.name= @"nameCharacter";
    
    [_character setZPosition:1];
    
    //
    [self addChild:_board];
    [_foreground addChild:_character];
    [_background addChild:_spriteBackground];
    
    [self addChild:_background];
    [self addChild:_foreground];

    _texturiMonster = [NSMutableArray array];
    for(int i=1 ;i<=4; i++)
        [_texturiMonster addObject:[_atlasBackground textureNamed:[NSString stringWithFormat:@"caramida%d.png",i]]];
    
    
    //Adaugam scorul
    _scorePoints = [[SKLabelNode alloc] init];
    _scorePoints.fontName = @"Chalkduster";
    _scorePoints.text = @"Bulletproofs: 5";
    [_scorePoints setZPosition:3];
    _scorePoints.fontSize = 15;
    _scorePoints.fontColor = [SKColor whiteColor];
    _scorePoints.position = CGPointMake(self.frame.size.width * 0.65, self.frame.size.height*0.97);
    
    //Cream sprite-ul de restart
    _myRestart = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"retryButton.png" ]];
    [_myRestart setZPosition: -121];
    [_myRestart setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_myRestart setPosition:CGPointMake(self.frame.size.width/2, self.frame.size.height*0.45) ];
    _myRestart.size = CGSizeMake(50, 50);
    _myRestart.name = @"nameRestart";	
    
    [self addChild:_myRestart];
//    [self addChild:_scorePoints];
    
    //adaugam simbolurile ce trebuie apasate
    _Shape1 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"1.png"]];
    _Shape2 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"2.png"]];
    _Shape3 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"3.png"]];
    _Shape4 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"4.png"]];
    
    [_Shape1 setZPosition:3];
    [_Shape2 setZPosition:3];
    [_Shape3 setZPosition:3];
    [_Shape4 setZPosition:3];
    
    [_Shape1 setXScale:0.45]; [_Shape1 setYScale:0.45];
    [_Shape2 setXScale:0.45]; [_Shape2 setYScale:0.45];
    [_Shape3 setXScale:0.45]; [_Shape3 setYScale:0.45];
    [_Shape4 setXScale:0.45]; [_Shape4 setYScale:0.45];
    
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
    _myLabel.fontColor = [SKColor whiteColor];
    [_myLabel setZPosition:3];
    _myLabel.fontSize = 18;
    _myLabel.fontName = @"Chalkduster";
    _myLabel.position = CGPointMake(self.frame.size.width * 0.66, self.frame.size.height * 0.93);
    [self addChild: _myLabel];
    
    //cream scorul
    _myScore = [[SKLabelNode alloc] init];
    _myScore.fontColor = [SKColor whiteColor];
    [_myScore setZPosition:3];
    _myScore.fontSize = 18;
    _myScore.fontName = @"Chalkduster";
    _myScore.position = CGPointMake(self.frame.size.width * 0.66, self.frame.size.height * 0.9);
    _myScore.text = @"score: 0";
    [self addChild: _myScore];
    
    //adaugam piulitele
    _piulita1 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"piulita.png"]];
    [_piulita1 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_piulita1 setPosition: CGPointMake(self.frame.size.width *0.69 , self.frame.size.height * 0.97 )];
    [_piulita1 setZPosition:500];
    [_piulita1 setXScale:0.08]; [_piulita1 setYScale:0.08];
    [self addChild:_piulita1];
    
    _piulita2 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"piulita.png"]];
    [_piulita2 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_piulita2 setPosition: CGPointMake(self.frame.size.width *0.66 , self.frame.size.height * 0.97 )];
    [_piulita2 setZPosition:500];
    [_piulita2 setXScale:0.08]; [_piulita2 setYScale:0.08];
    [self addChild:_piulita2];
    
    _piulita3 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"piulita.png"]];
    [_piulita3 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_piulita3 setPosition: CGPointMake(self.frame.size.width *0.63 , self.frame.size.height * 0.97 )];
    [_piulita3 setZPosition:500];
    [_piulita3 setXScale:0.08]; [_piulita3 setYScale:0.08];
    [self addChild:_piulita3];
    
    _piulita4 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"piulita.png"]];
    [_piulita4 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_piulita4 setPosition: CGPointMake(self.frame.size.width *0.60 , self.frame.size.height * 0.97 )];
    [_piulita4 setZPosition:500];
    [_piulita4 setXScale:0.08]; [_piulita4 setYScale:0.08];
    [self addChild:_piulita4];
    
    _piulita5 = [SKSpriteNode spriteNodeWithTexture:[_atlasBackground textureNamed:@"piulita.png"]];
    [_piulita5 setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [_piulita5 setPosition: CGPointMake(self.frame.size.width *0.57 , self.frame.size.height * 0.97 )];
    [_piulita5 setZPosition:500];
    [_piulita5 setXScale:0.08]; [_piulita5 setYScale:0.08];
    [self addChild:_piulita5];
    
    //Make background move
//    SKAction *moveRight = [SKAction runBlock:^{
//        [_spriteBackground runAction:[SKAction moveToX:540.0f duration:10]];
//    }];
//    NSLog(@"%f",_spriteBackground.position.x);
//    SKAction *moveLeft = [SKAction runBlock:^{
//        [_spriteBackground runAction:[SKAction moveToX:480.0f duration:10]];
//    }];
//    SKAction *runSequence = [SKAction sequence:@[moveRight, moveLeft]];
//    [self runAction:runSequence];
//    NSLog(@"%f",_spriteBackground.position.x);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    [self enumerateChildNodesWithName:@"nameRestart" usingBlock:^(SKNode *  node, BOOL * stop) {
        
        if( (SKSpriteNode *)node == (SKSpriteNode *)[self nodeAtPoint:location] )
        {
            [self removeAllChildren];
            [self removeAllActions];
            [self didMoveToView:self.view];
            [self resetAll];
        }
    }];

    

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

-(void)addMonster:(NSInteger)direction withSpeed:(NSInteger)speed{
    // Create sprite
    
    int nrModel = ((rand()+50)%999062 + rand())%4;
    
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithTexture:_texturiMonster[nrModel]];
    [monster setXScale:0.6]; [monster setYScale:0.6];
    monster.name = @"nameMonster";
    monster.anchorPoint = CGPointMake(0.5f, 1.f);
    monster.position = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    
    //Create actions
    SKAction *actionMove = [SKAction moveToY:120 duration:speed];
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
    SKLabelNode *monsterLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    monsterLabel.fontColor = [SKColor whiteColor];
    [monsterLabel setZPosition:2];
    monsterLabel.fontSize = 30;
    monsterLabel.name = @"nameLabel";
    
    NSMutableString *aux = [[NSMutableString alloc] init];
    for(int i=1; i<=numarDeCuvinte; i++)
    {
        [aux appendString:[NSMutableString stringWithFormat:@"%d", 1+(arc4random()%18481  + arc4random()%86767)%4]];
    }
    
    monsterLabel.text = aux;
    
    [monster addChild:monsterLabel];
    [_foreground addChild:monster];
}

-(void)changeTextureCharacter{
    SKAction *action1 = [SKAction runBlock:^{
        [_character setTexture:[_atlasBackground textureNamed:@"character1.png"]];
    }];
    SKAction *action2 = [SKAction runBlock:^{
        [_character setTexture:[_atlasBackground textureNamed:@"character2.png"]];
    }];
    SKAction *action3 = [SKAction runBlock:^{
        [_character setTexture:[_atlasBackground textureNamed:@"character3.png"]];
    }];
    SKAction *action4 = [SKAction runBlock:^{
        [_character setTexture:[_atlasBackground textureNamed:@"character4.png"]];
    }];
    SKAction *actionW1 = [SKAction waitForDuration:0.1];
    SKAction *actionW2 = [SKAction waitForDuration:0.4];
    SKAction *actionW3 = [SKAction waitForDuration:0.2];
    
    [_character setXScale:0.38]; [_character setYScale:0.32];
    SKAction *actionSequence = [SKAction sequence:@[action2, actionW3, action1, actionW2, action3, actionW1, action4, actionW1, action1]];
    [self runAction:actionSequence];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(Bulletproofs == 4)
        [_piulita5 removeFromParent];
    if(Bulletproofs == 3)
        [_piulita4 removeFromParent];
    if(Bulletproofs == 2)
        [_piulita3 removeFromParent];
    if(Bulletproofs == 1)
        [_piulita2 removeFromParent];
    if(Bulletproofs == 0)
        [_piulita5 removeFromParent];
    
    [_foreground enumerateChildNodesWithName:@"nameMonster" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if ( node.position.y  <= 150 && Bulletproofs>0)
        {
            Bulletproofs --;
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
                    NSMutableString *auxString = [[NSMutableString alloc] init];
                    if([_myLabel.text isEqualToString:aux.text])
                    {
                        _animationAction = [SKAction animateWithTextures:_texturiExplozie timePerFrame:1.0 / _atlasExplosion.textureNames.count];
                        
                        [node runAction:_animationAction completion:^{
                              [node removeFromParent];
                        }];
                        

                        _myString = [NSMutableString stringWithFormat:@"%@", auxString];
                        _myLabel.text = [NSString stringWithFormat:@"%@", auxString];
                        [self changeTextureCharacter];
                        numarUcideri++;
                        _myScore.text = [NSString stringWithFormat:@"score: %d", numarUcideri];
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
            ///////////////////////////
            [_myRestart setZPosition:400];
            [_myScore setPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height*0.38)];
        }
        
    }];
    
    if(divided >=90 && incrementAux % 240 == 0 && Bulletproofs>0)
    {
        incrementAux = 0;
        divided-=10;
    }
    incrementAux++;
    
    //Aici marim viteza monstrilor
    if(incrementViteza % 150 == 0 && viteza>8)
    {
        viteza-=0.5f;
        incrementViteza = 0;
    }
    
    //Aici marim numarul de cuvinte
    if(incrementCuv % 800 == 0 && numarDeCuvinte<7)
    {
        numarDeCuvinte++;
        incrementCuv = 0;
    }
    
    
    //Aici adaugam monstrii
    if(increment % divided == 0 && Bulletproofs>0)
    {
        [self addMonster:numarDeCuvinte withSpeed:viteza];
        increment = 0;
        
    }
    increment++;
    incrementCuv++;
    incrementViteza++;

}

@end
