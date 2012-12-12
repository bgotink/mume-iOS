//
//  Polar2dPoint.m
//  MoodSpots
//
//  Created by Thypo on 11/30/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Polar2dPoint.h"
#import "PolarCoordinate.h"

@implementation Polar2dPoint

+ (Polar2dPoint *)fromPolarCoordinate:(PolarCoordinate)polarCoord{
    Polar2dPoint *returnValue = [[Polar2dPoint alloc] init];
    returnValue.r = polarCoord.r;
    returnValue.phi = polarCoord.phi;
    return returnValue;
}

@end
