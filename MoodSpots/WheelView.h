//
//  WheelDrawer.h
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolarCoordinate.h"

@interface WheelView : UIView

@property (nonatomic) CGSize size;

@property (nonatomic) CGPoint wheelCenter;
@property float radius;

-(CGColorRef)colorFromHex:(NSString*)hex;

-(PolarCoordinate*)getPolar:(CGPoint)point;

@end
