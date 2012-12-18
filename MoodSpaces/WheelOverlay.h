//
//  WheelOverlay.h
//  MoodSpots
//
//  Created by Bram Gotink on 24/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WheelView.h"

@interface WheelOverlay : UIView

@property (nonatomic, strong) WheelView *wheelView;
@property (nonatomic, strong) NSMutableArray *points;

- (void)pointTapped:(CGPoint)point;
- (void)reset;

@end
