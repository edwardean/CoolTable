//
//  CustomCellBackground.m
//  CoolTable
//
//  Created by Edward on 13-6-16.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"
@implementation CustomCellBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    //Get the Core Graphics Context that you'll use in the rest of the method
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
//    UIColor *redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];//Red Color
//    
//    //Use this function any time fill a shape in the future
//    CGContextSetFillColorWithColor(context, redColor.CGColor);
//    
//    //Fill a given rectangle
//    CGContextFillRect(context, self.bounds);
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *lightGaryColor = [UIColor colorWithRed:230.0/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    UIColor *separatorColor =  [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
                               
    //UIColor *redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    CGRect paperRect = self.bounds;
    if (self.selected) {
        drawLinearGradient(context, paperRect, lightGaryColor.CGColor, separatorColor.CGColor);
    } else {
        drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGaryColor.CGColor);
    }
    //drawLinearGradient(context, paperRect, whiteColor.CGColor, lightGaryColor.CGColor);
    
    //CGRect strokeRect = CGRectInset(paperRect, 5.0, 5.0);
    //CGRect strokeRect = rectFor1PxStroke(CGRectInset(paperRect, 5.0, 5.0));
    CGRect strokeRect = paperRect;
    strokeRect.size.height -= 1;
    strokeRect = rectFor1PxStroke(strokeRect);
    CGContextSetStrokeColorWithColor(context, whiteColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
                               
    CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y+paperRect.size.height - 1);
    CGPoint endPoint = CGPointMake(paperRect.origin.x+paperRect.size.width-1, paperRect.origin.y + paperRect.size.height - 1);
    //draw1PxStroke(context, startPoint, endPoint, separatorColor.CGColor);
    if (!self.lastCell) {
        draw1PxStroke(context, startPoint, endPoint, separatorColor.CGColor);
    } else {
        CGContextSetStrokeColorWithColor(context, whiteColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        
        CGPoint pointA = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint pointB = CGPointMake(paperRect.origin.x, paperRect.origin.y);
        CGPoint pointC = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y);
        CGPoint pointD = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        
        draw1PxStroke(context, pointA, pointB, whiteColor.CGColor);
        draw1PxStroke(context, pointB, pointC, whiteColor.CGColor);
        draw1PxStroke(context, pointC, pointD, whiteColor.CGColor);
    }
                               
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
