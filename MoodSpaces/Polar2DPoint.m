//
//  Polar2dPoint.m
//  MoodSpots
//
//  Created by Thypo on 11/30/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "Polar2DPoint.h"
#import "PolarCoordinate.h"

@implementation Polar2DPoint

+ (Polar2DPoint *)fromPolarCoordinate:(PolarCoordinate)polarCoord{
    Polar2DPoint *returnValue = [[Polar2DPoint alloc] init];
    returnValue.r = polarCoord.r;
    returnValue.theta = polarCoord.theta;
    return returnValue;
}

@end
