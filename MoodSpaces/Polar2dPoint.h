//
//  Polar2dPoint.h
//  MoodSpots
//
//  Created by Thypo on 11/30/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolarCoordinate.h"

@interface Polar2dPoint : NSObject

@property float r;
@property float phi;

+ (Polar2dPoint *)fromPolarCoordinate:(PolarCoordinate)p;

@end
