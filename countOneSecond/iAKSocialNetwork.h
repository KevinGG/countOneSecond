//
//  iAKSocialNetwork.h
//  Craze's Adventure
//
//  Created by KangNing on 7/25/14.
//  Copyright (c) 2014 iAK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface iAKSocialNetwork : NSObject

-(instancetype)initWithUIViewController:(UIViewController*)viewController;

-(void)TwitterPost;

-(void)FacebookPost;


-(void)TwitterPost:(int)score;

-(void)FacebookPost:(int)score;


@end
