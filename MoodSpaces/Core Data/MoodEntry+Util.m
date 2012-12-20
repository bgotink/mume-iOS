//
//  MoodEntry+Util.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 20/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodEntry+Util.h"
#import "MoodActivity+Util.h"
#import "MoodSpot+Util.h"

@implementation MoodEntry (Util)

- (NSString *)description
{
    return [NSString stringWithFormat:@"MoodEntry with: %@ at:%@ doing:%@ feeling:%@", self.with, self.at, self.doing, self.feeling];
}

@end
