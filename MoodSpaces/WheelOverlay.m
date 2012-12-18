//
//  WheelOverlay.m
//  MoodSpots
//
//  Created by Bram Gotink on 24/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelOverlay.h"


#define MAX_NB_POINTS   2

@implementation WheelOverlay

@synthesize wheelView = _wheelView;

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

- (NSMutableArray *)points
{
    if (!_points) {
        _points = [[NSMutableArray  alloc] initWithCapacity:MAX_NB_POINTS];
    }
    return _points;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (!self.wheelView || self.points.count == 0) return;
    
    NSLog(@"Drawing WheelOverlay...");
    
    CGPoint _point;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for(PolarCoordinate *pc in self.points) {
        _point = [self.wheelView getCGPoint:pc];
        
        //Waarom hier transformatie ipv gewoon _point.x en _point.y in te vullen in de addArc?
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(_point.x, _point.y));
    
        CGContextAddArc(context, 0, 0, 5, 0, M_2_PI, 1);
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextFillPath(context);
    
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-_point.x, -_point.y));
    }
}

- (void)pointTapped:(CGPoint)point
{
    PolarCoordinate *coordinate = [self.wheelView getPolar:point];
    if(coordinate) {
        if(self.points.count >= MAX_NB_POINTS) {
            NSLog(@"Maximum nb points reached");
        } else {
            [self.points addObject:coordinate];
            [self setNeedsDisplay];
        }
    }
}

- (void)reset
{
    self.points = nil;
    [self setNeedsDisplay];
}

@end
