//
//  WheelDrawer.m
//  MoodSpots
//
//  Created by Bram Gotink on 20/10/12.
//  Copyright (c) 2012 KU Leuven Ariadne. All rights reserved.
//

#import "WheelDrawer.h"

@implementation WheelDrawer

typedef struct WDContext {
    CGContextRef ctx;
    int centerX;
    int centerY;
    int radius;
} WDContext;

@synthesize size = _size;

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
    
    _size = rect.size;
    
    int centerX = _size.width / 2;
    int centerY = _size.height / 2;
    int margin = 10;
    
    int radius = MIN(centerX, centerY) - margin;
    
    WDContext ctx;
    ctx.ctx = context;
    ctx.centerX = centerX;
    ctx.centerY = centerY;
    ctx.radius = radius;
    
    NSLog(@"radius: %d", radius);
    
    // Define all the colors, yay
    CGColorRef joyColor = [self colorFromHex:@"EDC500"];
    CGColorRef trustColor = [self colorFromHex:@"7BBD0D"];
    CGColorRef fearColor = [self colorFromHex:@"007B33"];
    CGColorRef surpriseColor = [self colorFromHex:@"0081AB"];
    CGColorRef sadnessColor = [self colorFromHex:@"1F6CAD"];
    CGColorRef disgustColor = [self colorFromHex:@"7B4EA3"];
    CGColorRef angerColor = [self colorFromHex:@"DC0047"];
    CGColorRef anticipationColor = [self colorFromHex:@"E87200"];
    
    
    [self drawPart:@"joy" withContext:ctx withColor:joyColor atIndex:6];
    [self drawPart:@"trust" withContext:ctx withColor:trustColor atIndex:7];
    [self drawPart:@"fear" withContext:ctx withColor:fearColor atIndex:0];
    [self drawPart:@"surprise" withContext:ctx withColor:surpriseColor atIndex:1];
    [self drawPart:@"sadness" withContext:ctx withColor:sadnessColor atIndex:2];
    [self drawPart:@"disgust" withContext:ctx withColor:disgustColor atIndex:3];
    [self drawPart:@"anger" withContext:ctx withColor:angerColor atIndex:4];
    [self drawPart:@"anticipation" withContext:ctx withColor:anticipationColor atIndex:5];
}

-(void)drawPart:(NSString*)name withContext:(WDContext)context withColor:(CGColorRef)color atIndex:(int)index
{
    float curAngle = index * M_PI_4;
    float nextAngle = curAngle + M_PI_4;
    int radius = context.radius;
    
    NSLog(@"Drawing wheel part %s", name.UTF8String);
    
    // set the color
    CGContextSetFillColorWithColor(context.ctx, color);
    CGContextSetStrokeColorWithColor(context.ctx, color);
    
    // draw the arc
    
    // this draws the top of the arc
    CGMutablePathRef outerPath = CGPathCreateMutable();
    
    CGPathAddArc(outerPath, nil, context.centerX, context.centerY, radius, curAngle, nextAngle, 0);
    
    CGContextAddPath(context.ctx, outerPath);
    CGContextFillPath(context.ctx);
    
    CGContextAddPath(context.ctx, outerPath);
    CGContextStrokePath(context.ctx);
    
    CGPathRelease(outerPath);
    
    // this draws the interior
    CGMutablePathRef innerPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(innerPath, nil, context.centerX, context.centerY);
    CGPathAddLineToPoint(innerPath, nil,
                            context.centerX + radius * cos(curAngle),
                            context.centerY + radius * sin(curAngle));
    CGPathAddLineToPoint(innerPath, nil,
                            context.centerX + radius * cos(nextAngle),
                            context.centerY + radius * sin(nextAngle));
    CGPathAddLineToPoint(innerPath, nil, context.centerX, context.centerY);
    
    CGContextAddPath(context.ctx, innerPath);
    CGContextFillPath(context.ctx);
    
    CGContextAddPath(context.ctx, innerPath);
    CGContextStrokePath(context.ctx);
    
    CGPathRelease(innerPath);
    
    // Draw the text

    // transformation
    CGContextSetTextMatrix(context.ctx, CGAffineTransformMake(
                                                              1.0,  0.0,
                                                              0.0, -1.0,
                                                              0.0,  0.0));
    CGContextConcatCTM(context.ctx, CGAffineTransformMakeTranslation(context.centerX, context.centerY));
    CGContextConcatCTM(context.ctx, CGAffineTransformMakeRotation((curAngle + nextAngle) / 2));

    CGContextSetStrokeColorWithColor(context.ctx, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context.ctx, [UIColor whiteColor].CGColor);
    
    CGContextSelectFont(context.ctx, "Helvetica", 18, kCGEncodingMacRoman);
    
    CGContextSetTextDrawingMode(context.ctx, kCGTextFill);
    CGContextShowTextAtPoint(context.ctx, 40, 6, name.UTF8String, name.length);
    
    // undo transformation
    CGContextConcatCTM(context.ctx, CGAffineTransformMakeRotation(-(curAngle + nextAngle) / 2));
    CGContextConcatCTM(context.ctx, CGAffineTransformMakeTranslation(-context.centerX, -context.centerY));
    CGContextSetTextMatrix(context.ctx, CGAffineTransformIdentity);
}

-(CGColorRef)colorFromHex:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor].CGColor;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor].CGColor;
    
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
                           alpha:1.0f].CGColor;
}

-(void)pointClicked:(CGPoint)point
{
    NSLog(@"Tapped wheel");
}

@end
