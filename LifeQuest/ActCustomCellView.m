//
//  ActCustomCellView.m
//  Actualizer
//
//  Created by Ryan Milvenan on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActCustomCellView.h"

@implementation ActCustomCellView

/*
@synthesize whiteColor = _whiteColor;
@synthesize goldColor = _goldColor;
@synthesize tanColor = _tanColor;
@synthesize separatorColor = _separatorColor;
*/

@synthesize nameLabel;
@synthesize scoreLabel;

/*
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
    CGContextSaveGState(context);
    
    //Colors
    self.whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.tanColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.76 alpha:1.0];
    self.goldColor = [UIColor colorWithRed:1.0 green:0.84 blue:0.0 alpha:1.0];
    self.separatorColor = [UIColor colorWithRed:0.31 green:0.14 blue:0.07 alpha:1.0];
    
    //Rect Definitions
    CGRect paperRect = self.bounds;
    CGContextSetFillColorWithColor(context, self.whiteColor.CGColor);
    CGContextFillRect(context, paperRect);
    drawLinearGradient(context, paperRect, self.whiteColor.CGColor, self.tanColor.CGColor);
    
    CGRect strokeRect = rectFor1PxStroke(CGRectInset(paperRect, 3.0, 3.0));
    
    CGContextSetStrokeColorWithColor(context, self.goldColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, strokeRect);
    
    CGPoint startPoint = CGPointMake(paperRect.origin.x, 
                                     paperRect.origin.y + paperRect.size.height - 1);
    CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, 
                                   paperRect.origin.y + paperRect.size.height - 1);
    draw1PxStroke(context, startPoint, endPoint, self.separatorColor.CGColor);
    
    CGContextRestoreGState(context);
    //Outline for Cell
    
     CGRect underRect = paperRect;
     underRect.size.height -= 1;
     underRect = rectFor1PxStroke(underRect);
     CGContextSetStrokeColorWithColor(context, brownColor);
     CGContextStrokeRect(context, underRect);
     
}
*/

@end
