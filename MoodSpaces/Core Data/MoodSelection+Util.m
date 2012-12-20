//
//  MoodSelection+Util.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSelection+Util.h"

@implementation MoodSelection (Util)

- (NSString *)description
{
    return [NSString stringWithFormat:@"Selection [%d] (r=%f, theta=%f)", self.mood, [self.r floatValue], [self.theta floatValue]];
}

- (int)mood
{
    return ((int)([self.theta floatValue] * 4 * M_1_PI + 8)) % 8;
}

@end
