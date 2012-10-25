//
//  WheelOverlay.h
//  MoodSpots
//
//  Created by Bram Gotink on 24/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WheelView.h"

@interface WheelOverlay : UIView {
    WheelView *wheelView;
    CGPoint *points;
    int nbPoints;
}

@property (strong,nonatomic,setter=setWheelView:) WheelView *wheelView;

- (void)pointTapped:(CGPoint)point;

- (CGPoint*)getPoint:(int)index;
- (PolarCoordinate*)getPointPolar:(int)index;

@end
