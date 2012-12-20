//
//  MoodSpot+Utility.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 15/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpot.h"
#import <CoreLocation/CoreLocation.h>

@interface MoodSpot (Util)

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate;
- (NSString *)subtitle;
- (void)setVector:(double)vector forMood:(NSInteger)mood;
- (float)vectorForMood:(NSInteger)mood;


@end
