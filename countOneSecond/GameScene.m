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
    BOOL playBtnEnabled;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    startPlayFlag = NO;
    playBtnEnabled = YES;
    
    backGround = [[SKSpriteNode alloc]initWithColor:[RPColor lightBlue] size:self.frame.size];
    [backGround setAnchorPoint:CGPointZero];
    [backGround setPosition:CGPointZero];
    [self addChild:backGround];
    
    SKShapeNode *button = [SKShapeNode shapeNodeWithCircleOfRadius:70];
    [button setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100)];
    button.fillColor = [RPColor darkWhite];
    button.name = @"button";
    [self addChild:button];
    
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
    [self addChild:buttonLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = (SKNode *)[self nodeAtPoint:location];
    //social share btn touched
    [self socialShareBtnTouched:node];
    //play button not touched
    if(![self isPlayButtonTouched:node]) return;
    //play button touched
    [self onClickEffect:node];
    if (!startPlayFlag) {
        playBtnEnabled = NO;//disable play button temporarily (before player count start) / (after count down ends)
        [self resetScene];
        [self countDownAnimationOn:node];
    }else{
        [self scoreWithAnimation];
    }
}

- (void)resetScene{
    //move in play status
    startPlayFlag = YES;
    //remove score label
    if ([self childNodeWithName:@"scoreLabel"]) {[[self childNodeWithName:@"scoreLabel"] removeFromParent];}
    if ([self childNodeWithName:@"twitter"]) {[[self childNodeWithName:@"twitter"] removeFromParent];}
    if ([self childNodeWithName:@"facebook"]) {[[self childNodeWithName:@"facebook"] removeFromParent];}
    if ([self childNodeWithName:@"bestscore"]) {[[self childNodeWithName:@"bestscore"] removeFromParent];}
}


- (void)scoreWithAnimation{
    ti = [[NSDate date]timeIntervalSinceDate:startPlay];
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithText:@"You count: 0.000s"];
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
    [self addChild:scoreLabel];
    
    [scoreLabel runAction:[SKAction customActionWithDuration:1.0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        [scoreLabel setAlpha:elapsedTime];
        [scoreLabel setText:[NSString stringWithFormat:@"You count: %.003fs", ti * elapsedTime]];
        [scoreLabel setFontSize:100 - elapsedTime * 50];
    }] completion:^{
        [self socialNetworkWithAnimation];
        SKLabelNode *labelNode = (SKLabelNode *)[self childNodeWithName:@"buttonLabel"];
        [labelNode setText:@"PLAY"];
        [self setAndDisplayTheBestScore];
    }];
    
}

- (void)socialNetworkWithAnimation{
    SKSpriteNode *twitterNode = [[SKSpriteNode alloc]initWithImageNamed:@"Twitter"];
    [self addChild:twitterNode];
    [twitterNode setPosition:CGPointMake(self.frame.size.width*0.42, self.frame.size.height*0.3)];
    [twitterNode setScale:0.7];
    [twitterNode setAlpha:0.0];
    twitterNode.name = @"twitter";
    
    SKSpriteNode *facebookNode = [[SKSpriteNode alloc]initWithImageNamed:@"Facebook"];
    [self addChild:facebookNode];
    [facebookNode setPosition:CGPointMake(self.frame.size.width*0.58, self.frame.size.height*0.3)];
    [facebookNode setScale:0.7];
    [facebookNode setAlpha:0.0];
    facebookNode.name = @"facebook";
    
    [twitterNode runAction:[SKAction rotateByAngle:M_PI*2 duration:0.5]];
    [twitterNode runAction:[SKAction fadeInWithDuration:1.0]];
    [facebookNode runAction:[SKAction rotateByAngle:M_PI*2 duration:0.5]];
    [facebookNode runAction:[SKAction fadeInWithDuration:1.0]];
}

- (void)countDownAnimationOn:(SKNode *)node{
    SKLabelNode *labelNode = (SKLabelNode *)[self childNodeWithName:@"buttonLabel"];
    [labelNode runAction:[SKAction fadeOutWithDuration:.5] completion:^{
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
                                            [labelNode setText:@"GO"];
                                            [labelNode setAlpha:1.0];
                                            [labelNode runAction:[SKAction scaleTo:1.0 duration:0.3] completion:^{
                                                [labelNode runAction:[SKAction waitForDuration:0.2] completion:^{
                                                    [labelNode runAction:[SKAction fadeOutWithDuration:.5]];
                                                    [labelNode runAction:[SKAction scaleTo:3.0 duration:.5]completion:^{
                                                        startPlay = [NSDate date];
                                                        [labelNode setScale:1.0];
                                                        [labelNode setText:@"STOP"];
                                                        [labelNode setColor:[RPColor darkBlue]];
                                                        [labelNode runAction:[SKAction fadeInWithDuration:0.00001]];
                                                        playBtnEnabled = YES;
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
}

- (void)onClickEffect:(SKNode *)node{
    SKShapeNode *fadeOutNode = [SKShapeNode shapeNodeWithCircleOfRadius:70];
    [fadeOutNode setPosition:node.position];
    fadeOutNode.fillColor = [UIColor whiteColor];
    [self addChild:fadeOutNode];
    //0.5 for fade and scale
    [fadeOutNode runAction:[SKAction fadeOutWithDuration:.5]];
    [fadeOutNode runAction:[SKAction scaleTo:3.0 duration:.5] completion:^{
        [fadeOutNode removeFromParent];
    }];
}

- (void)socialShareBtnTouched:(SKNode *)node{
    if([node.name isEqualToString:@"twitter"]){
        [_sn TwitterPost];
    }else if([node.name isEqualToString:@"facebook"]){
        [_sn FacebookPost];
    }
}

- (BOOL)isPlayButtonTouched:(SKNode *)node{
    if(!playBtnEnabled) return NO;
    if(!node) return NO;
    if([node.name isEqualToString:@"button"] || [node.name isEqualToString:@"buttonLabel"]) return YES;
    return NO;
}

- (void)setAndDisplayTheBestScore{
    SKLabelNode *bestScore = [[SKLabelNode alloc]initWithFontNamed:@"AppleSDGothicNeo-Medium"];
    [bestScore setText:@"Best count:"];
    [bestScore setPosition:CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.2)];
    bestScore.name = @"bestscore";
    [self addChild:bestScore];
    bestScore.alpha = 0.0;
    [bestScore runAction:[SKAction fadeInWithDuration:1.0]];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}

@end
