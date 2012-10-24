//
//  WheelOverlay.m
//  MoodSpots
//
//  Created by Bram Gotink on 24/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelOverlay.h"

@implementation WheelOverlay

@synthesize point;
@synthesize pointSet;
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
    if (!pointSet || wheelView == nil)
        return;
    
    NSLog(@"Drawing WheelOverlay...");
    
    CGPoint _point = [self point];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(_point.x, _point.y));
    
    CGContextAddArc(context, 0, 0, 5, 0, M_2_PI, 1);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-_point.x, -_point.y));
}

- (void)pointTapped:(CGPoint)newPoint
{
    if([wheelView getPolar:newPoint] != nil) {
        point = newPoint;
        pointSet = true;
        [self setNeedsDisplay];
    }
}

@end
