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
        UIFont *headerFont = [UIFont fontWithName:@"GoldBox" size:20];
        _titleLabel.font = headerFont;
        [self addSubview:_titleLabel];
    }
    return self;
}

-(void) layoutSubviews {
    
    CGFloat coloredBoxMargin = 3.0;
    CGFloat coloredBoxHeight = 47.5;
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
    UIImage *scroll = [UIImage imageNamed:@"Header.png"];
    [scroll drawInRect:self.coloredBoxRect];
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = UITextAlignmentCenter;
    _titleLabel.opaque = YES;
    _titleLabel.backgroundColor = [UIColor clearColor];
    UIFont *headerFont = [UIFont fontWithName:@"Palatino-Bold" size:20];
    _titleLabel.font = headerFont;
    [self addSubview:_titleLabel];

}
@end
