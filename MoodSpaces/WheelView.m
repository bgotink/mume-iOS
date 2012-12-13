//
//  WheelDrawer.m
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelView.h"
#import "Log.h"

@interface WheelView ()

-(UIColor *)colorFromHex:(NSString*)hex;

@end

@implementation WheelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    wheelCenter.x = rect.size.width / 2;
    wheelCenter.y = rect.size.height / 2;
    int margin = 10;
    
    radius = MIN(wheelCenter.x, wheelCenter.y) - margin;
    
    MSLog(@"Drawing Wheel...");
    MSLog(@"Radius: %f", radius);
    MSLog(@"wheelCenter: %f x %f", wheelCenter.x, wheelCenter.y);
    
    // Define all the colors, yay
    UIColor *joyColor = [self colorFromHex:@"EDC500"];
    UIColor *trustColor = [self colorFromHex:@"7BBD0D"];
    UIColor *fearColor = [self colorFromHex:@"007B33"];
    UIColor *surpriseColor = [self colorFromHex:@"0081AB"];
    UIColor *sadnessColor = [self colorFromHex:@"1F6CAD"];
    UIColor *disgustColor = [self colorFromHex:@"7B4EA3"];
    UIColor *angerColor = [self colorFromHex:@"DC0047"];
    UIColor *anticipationColor = [self colorFromHex:@"E87200"];
    
    
    [self drawPart:@"joy" withContext:context withColor:joyColor.CGColor atIndex:6];
    [self drawPart:@"trust" withContext:context withColor:trustColor.CGColor atIndex:7];
    [self drawPart:@"fear" withContext:context withColor:fearColor.CGColor atIndex:0];
    [self drawPart:@"surprise" withContext:context withColor:surpriseColor.CGColor atIndex:1];
    [self drawPart:@"sadness" withContext:context withColor:sadnessColor.CGColor atIndex:2];
    [self drawPart:@"disgust" withContext:context withColor:disgustColor.CGColor atIndex:3];
    [self drawPart:@"anger" withContext:context withColor:angerColor.CGColor atIndex:4];
    [self drawPart:@"anticipation" withContext:context withColor:anticipationColor.CGColor atIndex:5];
}

-(void)drawPart:(NSString*)name withContext:(CGContextRef)context withColor:(CGColorRef)color atIndex:(int)index
{
    float curAngle = index * M_PI_4;
    float nextAngle = curAngle + M_PI_4;
    
    MSLog(@"Drawing wheel part %s", name.UTF8String);
    
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

-(UIColor *)colorFromHex:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//Returns the coordinates of the given point in polar format.
-(PolarCoordinate*)getPolar:(CGPoint)point
{
    MSLog(@"Tapped wheel");
    
    float x = point.x - wheelCenter.x;
    float y = point.y - wheelCenter.y;
    
    MSLog(@"Tap location: %f x %f", x, y);
    
    PolarCoordinate *retVal = malloc(sizeof(PolarCoordinate));
    retVal->r = sqrt(x * x + y * y) / radius;
    
    if (retVal->r > 1) {
        MSLog(@"Tapped outside of wheel, ignore");
        return nil;
    }
    
    retVal->theta = atan2f(-y, x);
    
    MSLog(@"Tap location polar: r = %f, theta = %f", retVal->r, retVal->theta);
    return retVal;
}

@end
