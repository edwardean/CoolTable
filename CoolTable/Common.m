//
//  Common.m
//  CoolTable
//
//  Created by Edward on 13-6-16.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "Common.h"
#import <Foundation/Foundation.h>
//绘画渐变色
void drawLinearGradient(CGContextRef context,CGRect rect,CGColorRef startColor,CGColorRef endColor) {
    
    //Get a color space with which we'll draw the gradient
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    NSArray *colors = @[(__bridge_transfer id)startColor,(__bridge_transfer id)endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge_retained CFArrayRef)colors, locations);
    
    
    //First calulate the start and end point for where you want to draw the gradient
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    //Well,remember that Core Grphics is a state machine, and once you've set something it stays that way until you change it back.
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

CGRect rectFor1PxStroke(CGRect rect){
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y+0.5, rect.size.width-1, rect.size.height-1);
}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color) {
    
    //At the begining and end of the function, we save/restore the context so we don't leave any changes we made around.
    CGContextSaveGState(context);
    
    //设置画笔笔帽
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    //设置描边颜色
    CGContextSetStrokeColorWithColor(context, color);
    
    //设置线条宽度
    CGContextSetLineWidth(context, 1.0);
    
    //根据所给点开始一个新的子路径
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    
    //根据所给点在当前点上追加一段直线段
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    
    //绘画描边路径
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}