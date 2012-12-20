//
//  MoodSpotAnnotation.m
//  MoodSpaces
//
//  Created by Michiel Staessen on 13/12/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "MoodSpotAnnotation.h"
#import "UIColor+Hex.h"

#define DEFAULT_RADIUS 24.0

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

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.moodSpot.latitude doubleValue], [self.moodSpot.longitude doubleValue]);
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.moodSpot.latitude = [NSNumber numberWithDouble:newCoordinate.latitude];
    self.moodSpot.longitude = [NSNumber numberWithDouble:newCoordinate.longitude];
}

- (NSArray *)colors
{
    UIColor *joyColor = [UIColor colorFromHex:@"EDC500"];
    UIColor *trustColor = [UIColor colorFromHex:@"7BBD0D"];
    UIColor *fearColor = [UIColor colorFromHex:@"007B33"];
    UIColor *surpriseColor = [UIColor colorFromHex:@"0081AB"];
    UIColor *sadnessColor = [UIColor colorFromHex:@"1F6CAD"];
    UIColor *disgustColor = [UIColor colorFromHex:@"7B4EA3"];
    UIColor *angerColor = [UIColor colorFromHex:@"DC0047"];
    UIColor *anticipationColor = [UIColor colorFromHex:@"E87200"];
    return [NSArray arrayWithObjects: fearColor, surpriseColor, sadnessColor, disgustColor, angerColor, anticipationColor, joyColor, trustColor, nil];
}

- (void)drawCircleWithRadius:(CGFloat)radius withColor:(UIColor *)color inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextSetLineWidth(context, 5.0);
    [color setFill];
    CGContextBeginPath(context);
    CGContextAddArc(context, DEFAULT_RADIUS, DEFAULT_RADIUS, radius, 0, 2*M_PI, YES);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

- (UIImage *)visualization
{
    UIGraphicsBeginImageContext(CGSizeMake(2 * DEFAULT_RADIUS, 2 * DEFAULT_RADIUS));
	CGContextRef context = UIGraphicsGetCurrentContext();

    // calculate vector sum
    float vectorSum = 0.0;
    for (int mood = 0; mood < 8; mood++) {
        vectorSum += [self.moodSpot vectorForMood:mood];
    }
    
    if (vectorSum > 0) {
        float radius = DEFAULT_RADIUS;
        for (int mood = 0; mood < 8; mood++) {
            float moodBandWidth = DEFAULT_RADIUS * [self.moodSpot vectorForMood:mood] / vectorSum;
            if (moodBandWidth > 0) {
                NSLog(@"band for %d is %f wide", mood, moodBandWidth);
                [self drawCircleWithRadius:radius
                                withColor:[[self colors] objectAtIndex:mood]
                                inContext:context];
                radius -= moodBandWidth;
            }
        }
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return image;
}

@end
