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

@end
