//
//  ActCustomHeader.m
//  Actualizer
//
//  Created by Ryan Milvenan on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActCustomHeader.h"
#import "ActCommon.h"

@implementation ActCustomHeader

@synthesize titleLabel = _titleLabel;
@synthesize lightColor = _lightColor;
@synthesize darkColor = _darkColor;
@synthesize tanColor = _tanColor;
@synthesize shadowColor = _shadowColor;
@synthesize coloredBoxRect = _coloredBoxRect;
@synthesize paperRect = _paperRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.opaque = YES;
        _titleLabel.backgroundColor = [UIColor clearColor];
        UIFont *headerFont = [UIFont fontWithName:@"Palatino-Bold" size:20];
        _titleLabel.font = headerFont;
        _titleLabel.textColor = [UIColor colorWithRed:212.0/255.0 green:175.0/255.0 blue:55.0/255.0 alpha:1.0];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:_titleLabel];
        self.lightColor = [UIColor colorWithRed:0.39 green:0.22 blue:0.15 alpha:1.0];
        self.darkColor = [UIColor colorWithRed:0.31 green:0.14 blue:0.07 alpha:1.0];
        self.tanColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.76 alpha:1.0];
        self.shadowColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]; 
        
    }
    return self;
}

-(void) layoutSubviews {
    
    CGFloat coloredBoxMargin = 6.0;
    CGFloat coloredBoxHeight = 40.0;
    self.coloredBoxRect = CGRectMake(coloredBoxMargin, 
                                 coloredBoxMargin, 
                                 self.bounds.size.width-coloredBoxMargin*2, 
                                 coloredBoxHeight);
    
    CGFloat paperMargin = 9.0;
    self.paperRect = CGRectMake(paperMargin, 
                            CGRectGetMaxY(_coloredBoxRect), 
                            self.bounds.size.width-paperMargin*2, 
                            self.bounds.size.height-CGRectGetMaxY(_coloredBoxRect));
    
    _titleLabel.frame = self.coloredBoxRect;
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    CGContextSaveGState(context);      
    CGContextSetFillColorWithColor(context, self.tanColor.CGColor);
    CGContextFillRect(context, _paperRect);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, self.shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    CGContextFillRect(context, _coloredBoxRect);
    drawGlossAndGradient(context, self.coloredBoxRect, self.lightColor.CGColor, self.darkColor.CGColor);  
    
    
    // Draw stroke
    CGContextSetStrokeColorWithColor(context, self.darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1PxStroke(_coloredBoxRect));
    CGContextRestoreGState(context);
}


@end
