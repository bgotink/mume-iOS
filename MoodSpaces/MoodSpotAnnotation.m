//
//  MoodSpotAnnotation.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotAnnotation.h"


@interface MoodSpotAnnotation ()

@end

@implementation MoodSpotAnnotation

@synthesize moodSpot = _moodSpot;

+ (MoodSpotAnnotation *)annotationForMoodSpot:(MoodSpot *)moodSpot
{
    MoodSpotAnnotation *annotation = [[MoodSpotAnnotation alloc] init];
    annotation.moodSpot = moodSpot;
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

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.moodSpot.latitude = [NSNumber numberWithDouble:newCoordinate.latitude];
    self.moodSpot.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
}

@end
