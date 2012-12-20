//
//  MoodActivity+Util.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodActivity+Util.h"

@implementation MoodActivity (Util)

- (NSString *)description
{
    return self.name;
}

- (void)setVector:(double)vector forMood:(NSInteger)mood
{
    switch (mood) {
        case 0:
            self.fearVector = [NSNumber numberWithDouble:vector];
            break;
        case 1:
            self.surpriseVector = [NSNumber numberWithDouble:vector];
            break;
        case 2:
            self.sadnessVector = [NSNumber numberWithDouble:vector];
            break;
        case 3:
            self.disgustVector = [NSNumber numberWithDouble:vector];
            break;
        case 4:
            self.angerVector = [NSNumber numberWithDouble:vector];
            break;
        case 5:
            self.anticipationVector = [NSNumber numberWithDouble:vector];
            break;
        case 6:
            self.joyVector = [NSNumber numberWithDouble:vector];
            break;
        case 7:
            self.trustVector = [NSNumber numberWithDouble:vector];
            break;
    }
}

- (NSString *)vectorForMood:(NSInteger)mood
{
    NSNumber *result;
    switch (mood) {
        case 0:
            result = self.fearVector;
            break;
        case 1:
            result = self.surpriseVector;
            break;
        case 2:
            result = self.sadnessVector;
            break;
        case 3:
            result = self.disgustVector;
            break;
        case 4:
            result = self.angerVector;
            break;
        case 5:
            result = self.anticipationVector;
            break;
        case 6:
            result = self.joyVector;
            break;
        case 7:
            result = self.trustVector;
            break;
    }
    return [NSString stringWithFormat:@"%1.2f", [result floatValue]];
}

@end
