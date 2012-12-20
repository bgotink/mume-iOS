//
//  MoodSpotAnnotation.h
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MoodSpot+Util.h"

@interface MoodSpotAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) MoodSpot *moodSpot;

+ (MoodSpotAnnotation *) annotationForMoodSpot:(MoodSpot *)moodSpot;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

- (UIImage *)visualization;

@end
