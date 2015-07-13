//
//  GameScene.m
//  countOneSecond
//
//  Created by Xiaonan Wang on 7/8/15.
//  Copyright (c) 2015 RightPaw. All rights reserved.
//

#import "GameScene.h"
#import "RPColor.h"

@implementation GameScene{
    SKSpriteNode *backGround;
    NSDate *startPlay;
    NSTimeInterval ti;
    BOOL startPlayFlag;
    
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    backGround = [[SKSpriteNode alloc]initWithColor:[RPColor lightBlue] size:self.frame.size];
    [backGround setAnchorPoint:CGPointZero];
    [backGround setPosition:CGPointZero];
    [self addChild:backGround];
    
    SKShapeNode *button = [SKShapeNode shapeNodeWithCircleOfRadius:70];
    [button setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100)];
    button.fillColor = [RPColor darkWhite];
    button.name = @"button";
    [backGround addChild:button];
    
    SKLabelNode *buttonLabel = [SKLabelNode labelNodeWithText:@"PLAY"];
    [buttonLabel setColor:[SKColor redColor]];
    [buttonLabel setPosition:button.position];
    [buttonLabel setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    [buttonLabel setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [buttonLabel setZPosition:100.0];
    [buttonLabel setFontName:@"AppleSDGothicNeo-Medium"];
    [buttonLabel setFontSize:50];
    [buttonLabel setFontColor:[RPColor lightBlue]];
    buttonLabel.name = @"buttonLabel";
    startPlayFlag = NO;
    [backGround addChild:buttonLabel];
    
    if ([backGround childNodeWithName:@"buttonLabel"]) {
        NSLog(@"added");
    }else{
        NSLog(@"NO");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = (SKNode *)[self nodeAtPoint:location];
        if ([node.name isEqualToString:@"button"]||[node.name isEqualToString:@"buttonLabel"]) {
            if (!startPlayFlag) {
                startPlayFlag = YES;
                if ([backGround childNodeWithName:@"scoreLabel"]) {
                    [[backGround childNodeWithName:@"scoreLabel"] removeFromParent];
                }
                SKShapeNode *fadeOutNode = [SKShapeNode shapeNodeWithCircleOfRadius:70];
                [fadeOutNode setPosition:node.position];
                fadeOutNode.fillColor = [UIColor whiteColor];
                [self addChild:fadeOutNode];
                [fadeOutNode runAction:[SKAction fadeOutWithDuration:.5]];
                [fadeOutNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                    [fadeOutNode removeFromParent];
                }];
                
                SKLabelNode *labelNode = (SKLabelNode *)[backGround childNodeWithName:@"buttonLabel"];
                [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                [labelNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                    [labelNode setScale:0.1];
                    [labelNode setText:@"3"];
                    [labelNode setAlpha:1.0];
                    [labelNode runAction:[SKAction scaleTo:1.0 duration:0.3] completion:^{
                        [labelNode runAction:[SKAction waitForDuration:0.2] completion:^{
                            [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                            [labelNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                                [labelNode setScale:0.1];
                                [labelNode setText:@"2"];
                                [labelNode setAlpha:1.0];
                                [labelNode runAction:[SKAction scaleTo:1.0 duration:0.3] completion:^{
                                    [labelNode runAction:[SKAction waitForDuration:0.2] completion:^{
                                        [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                                        [labelNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                                            [labelNode setScale:0.1];
                                            [labelNode setText:@"1"];
                                            [labelNode setAlpha:1.0];
                                            [labelNode runAction:[SKAction scaleTo:1.0 duration:0.3] completion:^{
                                                [labelNode runAction:[SKAction waitForDuration:0.2] completion:^{
                                                    [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                                                    [labelNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                                                        [labelNode setScale:0.1];
                                                        [labelNode setText:@"START"];
                                                        [labelNode setAlpha:1.0];
                                                        [labelNode runAction:[SKAction scaleTo:1.0 duration:0.3] completion:^{
                                                            [labelNode runAction:[SKAction waitForDuration:0.2] completion:^{
                                                                [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                                                                [labelNode runAction:[SKAction scaleTo:3.0 duration:.5]completion:^{
                                                                    startPlay = [NSDate date];
                                                                    [labelNode setScale:1.0];
                                                                    [labelNode setText:@"1 Sec"];
                                                                    [labelNode setColor:[RPColor darkBlue]];
                                                                    [labelNode runAction:[SKAction fadeInWithDuration:1.0]];
                                                                }];
                                                            }];
                                                        }];
                                                    }];
                                                }];
                                            }];
                                        }];
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
                
                
            }else{
                ti = [[NSDate date]timeIntervalSinceDate:startPlay];
                SKShapeNode *fadeOutNode = [SKShapeNode shapeNodeWithCircleOfRadius:70];
                [fadeOutNode setPosition:node.position];
                fadeOutNode.fillColor = [UIColor whiteColor];
                [self addChild:fadeOutNode];
                [fadeOutNode runAction:[SKAction fadeOutWithDuration:.5]];
                [fadeOutNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
                    [fadeOutNode removeFromParent];
                }];
                
                SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithText:@"Result: 0.000s"];
                [scoreLabel setColor:[SKColor redColor]];
                [scoreLabel setPosition:CGPointMake(CGRectGetMidX(backGround.frame), backGround.frame.size.height * 2 / 5)];
                [scoreLabel setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
                [scoreLabel setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
                [scoreLabel setZPosition:100.0];
                [scoreLabel setFontName:@"AppleSDGothicNeo-Medium"];
                [scoreLabel setFontSize:100];
                [scoreLabel setAlpha:0.0];
                [scoreLabel setFontColor:[RPColor darkWhite]];
                scoreLabel.name = @"scoreLabel";
                startPlayFlag = NO;
                [backGround addChild:scoreLabel];
                
                [scoreLabel runAction:[SKAction customActionWithDuration:1.0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
                    [scoreLabel setAlpha:elapsedTime];
                    [scoreLabel setText:[NSString stringWithFormat:@"Result: %.003fs", ti * elapsedTime]];
                    [scoreLabel setFontSize:100 - elapsedTime * 50];
                }]];
                
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}

@end
