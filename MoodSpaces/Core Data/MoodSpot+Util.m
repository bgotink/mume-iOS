//
//  MoodSpot+Utility.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot+Util.h"

@implementation MoodSpot (Util)

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"Update MoodSpot location to lat:%f, long:%f", coordinate.latitude, coordinate.longitude);
    self.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:coordinate.longitude];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"MoodSpot '%@' at latitude %@ and longitude %@", self.name, self.latitude, self.longitude];
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"latitude: %@, longitude: %@", self.latitude, self.longitude];
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

- (float)vectorForMood:(NSInteger)mood
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
    return [result floatValue];
}


@end
