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

@property (strong,nonatomic,setter=setWheelView:) WheelView *wheelView;

@property (nonatomic) CGPoint point;
@property (nonatomic) bool pointSet;

-(void)pointTapped:(CGPoint)point;

@end
