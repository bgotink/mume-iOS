//
//  WheelDrawer.m
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelView.h"
#import "UIColor+Hex.h"

#define DEFAULT_SCALE 0.9

@interface WheelView ()

@end

@implementation WheelView

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint wheelCenter;
    wheelCenter.x = self.bounds.origin.x + self.bounds.size.width / 2;
    wheelCenter.y = self.bounds.origin.y + self.bounds.size.height / 2;
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * DEFAULT_SCALE / 2;
    
    NSLog(@"Drawing Wheel with radius: %f at (%f, %f)", radius, wheelCenter.x, wheelCenter.y);
    
    // Define all the colors, yay
    UIColor *joyColor = [UIColor colorFromHex:@"EDC500"];
    UIColor *trustColor = [UIColor colorFromHex:@"7BBD0D"];
    UIColor *fearColor = [UIColor colorFromHex:@"007B33"];
    UIColor *surpriseColor = [UIColor colorFromHex:@"0081AB"];
    UIColor *sadnessColor = [UIColor colorFromHex:@"1F6CAD"];
    UIColor *disgustColor = [UIColor colorFromHex:@"7B4EA3"];
    UIColor *angerColor = [UIColor colorFromHex:@"DC0047"];
    UIColor *anticipationColor = [UIColor colorFromHex:@"E87200"];

    [self drawPartWithName:@"fear" atIndex:0 withColor:fearColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"surprise" atIndex:1 withColor:surpriseColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"sadness" atIndex:2 withColor:sadnessColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"disgust" atIndex:3 withColor:disgustColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"anger" atIndex:4 withColor:angerColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"anticipation" atIndex:5 withColor:anticipationColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"joy" atIndex:6 withColor:joyColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
    [self drawPartWithName:@"trust" atIndex:7 withColor:trustColor.CGColor fromCenter:wheelCenter withRadius:radius inContext:context];
}

-(void)drawPartWithName:(NSString*)name
                atIndex:(int)index
              withColor:(CGColorRef)color
             fromCenter:(CGPoint)wheelCenter
             withRadius:(CGFloat)radius
              inContext:(CGContextRef)context
{
    float curAngle = index * M_PI_4;
    float nextAngle = curAngle + M_PI_4;
    
    NSLog(@"Drawing wheel part %s", name.UTF8String);
    
    // set the color
    CGContextSetFillColorWithColor(context, color);
    CGContextSetStrokeColorWithColor(context, color);
    
    // draw the arc
    
    // this draws the top of the arc
    CGMutablePathRef outerPath = CGPathCreateMutable();
    
    CGPathAddArc(outerPath, nil, wheelCenter.x, wheelCenter.y, radius, curAngle, nextAngle, 0);
    
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    
    CGPathRelease(outerPath);
    
    // this draws the interior
    CGMutablePathRef innerPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(innerPath, nil, wheelCenter.x, wheelCenter.y);
    CGPathAddLineToPoint(innerPath, nil,
                            wheelCenter.x + radius * cos(curAngle),
                            wheelCenter.y + radius * sin(curAngle));
    CGPathAddLineToPoint(innerPath, nil,
                            wheelCenter.x + radius * cos(nextAngle),
                            wheelCenter.y + radius * sin(nextAngle));
    CGPathAddLineToPoint(innerPath, nil, wheelCenter.x, wheelCenter.y);
    
    CGContextAddPath(context, innerPath);
    CGContextFillPath(context);
    
    CGContextAddPath(context, innerPath);
    CGContextStrokePath(context);
    
    CGPathRelease(innerPath);
    
    // Draw the text

    // transformation
    
    if((index < 2) || (index > 5)){
        CGContextSetTextMatrix(context, CGAffineTransformMake(
                                                              1.0,  0.0,
                                                              0.0, -1.0,
                                                              0.0,  0.0));
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(wheelCenter.x, wheelCenter.y));
        CGContextConcatCTM(context, CGAffineTransformMakeRotation((curAngle + nextAngle) / 2));

        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
        CGContextSelectFont(context, "Helvetica", 18, kCGEncodingMacRoman);
    
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextShowTextAtPoint(context, 60, 6, name.UTF8String, name.length);
    
        // undo transformation
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(-(curAngle + nextAngle) / 2));
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-wheelCenter.x, -wheelCenter.y));
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    } else{
        CGContextSetTextMatrix(context, CGAffineTransformMake(
                                                              1.0,  0.0,
                                                              0.0, -1.0,
                                                              0.0,  0.0));
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(wheelCenter.x, wheelCenter.y));
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(((curAngle + nextAngle) / 2)-M_PI));
        
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        
        CGContextSelectFont(context, "Helvetica", 18, kCGEncodingMacRoman);
        
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextShowTextAtPoint(context, -wheelCenter.x + 40, 6, name.UTF8String, name.length);
        
        // undo transformation
        CGContextConcatCTM(context, CGAffineTransformMakeRotation(-(((curAngle + nextAngle) / 2) - M_PI)));
        CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-wheelCenter.x, -wheelCenter.y));
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    }
}

//Returns the coordinates of the given point in polar format.
- (PolarCoordinate *)getPolar:(CGPoint)point
{
    CGPoint wheelCenter;
    wheelCenter.x = self.bounds.origin.x + self.bounds.size.width / 2;
    wheelCenter.y = self.bounds.origin.y + self.bounds.size.height / 2;
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * DEFAULT_SCALE / 2;
    
    float x = point.x - wheelCenter.x;
    float y = point.y - wheelCenter.y;
    
    PolarCoordinate *result = [[PolarCoordinate alloc] init];
    result.r = sqrt(x * x + y * y) / radius;
    
    if(result.r > 1) {
        return nil;
    }
    
    result.theta = atan2f(y, x);
    
    NSLog(@"Tap location polar: r = %f, theta = %f", result.r, result.theta);
    NSLog(@"Mood Index = %d", (int)(result.theta * 4 * M_1_PI + 8) % 8);
    return result;
}

- (CGPoint)getCGPoint:(PolarCoordinate *)polarCoordinate
{
    CGPoint wheelCenter;
    wheelCenter.x = self.bounds.origin.x + self.bounds.size.width / 2;
    wheelCenter.y = self.bounds.origin.y + self.bounds.size.height / 2;
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) * DEFAULT_SCALE / 2;
    
    return CGPointMake(wheelCenter.x + polarCoordinate.r * radius * cosf(polarCoordinate.theta), wheelCenter.y + polarCoordinate.r * radius * sinf(polarCoordinate.theta));
}

@end
