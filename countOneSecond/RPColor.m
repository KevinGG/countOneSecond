//
//  RPColor.m
//  countOneSecond
//
//  Created by Xiaonan Wang on 7/9/15.
//  Copyright (c) 2015 RightPaw. All rights reserved.
//

#import "RPColor.h"

#define Rgb2UIColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@implementation RPColor

+(UIColor *)lightBlue{
    return Rgb2UIColor(62,180,245,1);
}

+(UIColor *)darkBlue{
    return Rgb2UIColor(42,124,168,1);
}

+(UIColor *)lightYellow{
    return Rgb2UIColor(245,187,61,1);
}

+(UIColor *)darkYellow{
    return Rgb2UIColor(168,107,42,1);
}

+(UIColor *)lightBlack{
    return Rgb2UIColor(10,10,10,1);
}

+(UIColor *)darkWhite{
    return Rgb2UIColor(245,245,245,1);
}

@end
