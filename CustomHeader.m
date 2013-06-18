//
//  CustomHeader.m
//  CoolTable
//
//  Created by Edward on 13-6-18.
//  Copyright (c) 2013年 Lihang. All rights reserved.
//

#import "CustomHeader.h"
#import "Common.h"
@interface CustomHeader ()
@property (nonatomic, assign) CGRect coloredBoxRect;
@property (nonatomic, assign) CGRect paperRect;//Draw shadow
@end
@implementation CustomHeader

- (id) init {
    self  = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:_titleLabel];
        
        _lightColor = [UIColor colorWithRed:0.289 green:0.570 blue:0.702 alpha:1.000];
        _darkColor = [UIColor colorWithRed:0.141 green:0.360 blue:0.533 alpha:1.000];
    }
    return self;
}

// You should not call this method directly. If you want to force a layout update, call the setNeedsLayout method instead to do so prior to the next drawing update. If you want to update the layout of your views immediately, call the layoutIfNeeded method.
- (void) layoutSubviews {
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    self.coloredBoxRect = CGRectMake(coloredBoxMargin, coloredBoxMargin, self.bounds.size.width - coloredBoxMargin * 2, coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    self.paperRect = CGRectMake(paperMargin, CGRectGetMaxY(self.coloredBoxRect), self.bounds.size.width - paperMargin*2, self.bounds.size.height-CGRectGetMaxY(self.coloredBoxRect));
    
    self.titleLabel.frame = self.coloredBoxRect;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //取得当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor *shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    //设置当前图形上下文颜色
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    //阴影部分底色填充为白色
    CGContextFillRect(context, _paperRect);
    
    CGContextSaveGState(context);
    //填充阴影部分颜色为灰色
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 2.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    
    CGContextFillRect(context, self.coloredBoxRect);
    CGContextRestoreGState(context);
    //在当前图形上下文中用指定颜色填充矩形
    //CGContextFillRect(context, self.bounds);
//    CGContextFillRect(context, self.coloredBoxRect);
//    
//    CGContextSetFillColorWithColor(context, greenColor.CGColor);
//    CGContextFillRect(context, self.paperRect);
    
    //绘画遮罩
    drawGlossAndGradient(context, self.coloredBoxRect, self.lightColor.CGColor, self.darkColor.CGColor);
    
    //用darkColor颜色描边
    CGContextSetStrokeColorWithColor(context, self.darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rectFor1PxStroke(self.coloredBoxRect));
}

@end
