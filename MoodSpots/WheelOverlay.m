//
//  WheelOverlay.m
//  MoodSpots
//
//  Created by Bram Gotink on 24/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelOverlay.h"

#define MAX_NB_POINTS   4

@implementation WheelOverlay

@synthesize points;
@synthesize nbPoints;
@synthesize wheelView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if ((nbPoints == 0) || wheelView == nil)
        return;
    
    NSLog(@"Drawing WheelOverlay...");
    
    CGPoint _point;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int i;
    for(i = 0; i < nbPoints; i++) {
        _point = points[i];
        
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(_point.x, _point.y));
    
        CGContextAddArc(context, 0, 0, 5, 0, M_2_PI, 1);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillPath(context);
    
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-_point.x, -_point.y));
    }
}

- (void)pointTapped:(CGPoint)newPoint
{
    if (points == nil) {
        points = malloc(sizeof(CGPoint) * MAX_NB_POINTS);
        if (points == nil) {
            NSLog(@"Failed to create CGPoint array!!!");
            return;
        }
    }
    
    if(nbPoints >= MAX_NB_POINTS) {
        NSLog(@"Maximum nb points reached");
        return;
    }
    
    if([wheelView getPolar:newPoint] != nil) {
        points[nbPoints++] = newPoint;
        [self setNeedsDisplay];
    }
}

- (CGPoint*)getPoint:(int)index
{
    if (points == nil)
        return nil;
    
    if (index < 0 || index >= nbPoints)
        return nil;
    return &points[index];
}

- (PolarCoordinate*)getPointPolar:(int)index
{
    if (points == nil)
        return nil;
    
    if (index < 0 || index >= nbPoints)
        return nil;
    return [wheelView getPolar:points[index]];
}

@end
