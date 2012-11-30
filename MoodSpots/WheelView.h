//
//  WheelDrawer.h
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolarCoordinate.h"

@interface WheelView : UIView {
    CGSize size;
    CGPoint wheelCenter;
    float radius;
}

-(PolarCoordinate*)getPolar:(CGPoint)point;

@end
