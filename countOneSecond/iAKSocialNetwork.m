//
//  iAKSocialNetwork.m
//  Craze's Adventure
//
//  Created by KangNing on 7/25/14.
//  Copyright (c) 2014 iAK. All rights reserved.
//

#import "iAKSocialNetwork.h"

@interface iAKSocialNetwork()
@property (strong, nonatomic)UIViewController* viewController;
@end

@implementation iAKSocialNetwork


-(instancetype)initWithUIViewController:(UIViewController*)viewController{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

-(void)TwitterPost{
    NSLog(@"Twitter post");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I'm playing #countOneSecond ! It's simple but fun! See how good your feeling of time is! Can you beat me?"];
        //[tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/rainbow-crash/id903688862?ls=1&mt=8"]];
        [tweetSheet addImage:[self getScreenShot]];
        [self.viewController presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)TwitterPost:(int)score{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"I'm playing #countOneSecond ! It's simple but fun! See how good your feeling of time is! Can you beat me?"];
        //[tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/rainbow-crash/id903688862?ls=1&mt=8"]];
        [tweetSheet addImage:[self getScreenShot]];
        [self.viewController presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)FacebookPost{
    NSLog(@"Facebook post");
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebooksheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebooksheet setInitialText:@"I'm playing #countOneSecond ! It's simple but fun! See how good your feeling of time is! Can you beat me?"];
        //[facebooksheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/rainbow-crash/id903688862?ls=1&mt=8"]];
        [facebooksheet addImage:[self getScreenShot]];
        [self.viewController presentViewController:facebooksheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a post right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)FacebookPost:(int)score{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebooksheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebooksheet setInitialText:@"I'm playing #countOneSecond ! It's simple but fun! See how good your feeling of time is! Can you beat me?"];
        //[facebooksheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/rainbow-crash/id903688862?ls=1&mt=8"]];
        [facebooksheet addImage:[self getScreenShot]];
        [self.viewController presentViewController:facebooksheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a post right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

-(UIImage *)getScreenShot{
    UIGraphicsBeginImageContextWithOptions(self.viewController.view.bounds.size, NO, 10);
    [self.viewController.view drawViewHierarchyInRect:self.viewController.view.bounds afterScreenUpdates:YES];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
