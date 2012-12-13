//
//  MoodSpotAnnotation.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotAnnotation.h"

@implementation MoodSpotAnnotation

@synthesize moodSpot = _moodSpot;

+ (MoodSpotAnnotation *)annotationForMoodSpot:(MoodSpot *)moodSpot
{
    MoodSpotAnnotation *annotation = [[MoodSpotAnnotation alloc] init];
    [annotation setMoodSpot:moodSpot];
    return annotation;
}

- (NSString *)title
{
    return self.moodSpot.name;
}

- (NSString *)subtitle
{
    return @"Some Description";
}

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.moodSpot.latitude doubleValue], [self.moodSpot.longitude doubleValue]);
}

@end
