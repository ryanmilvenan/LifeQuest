//
//  ActCustomCellView.h
//  Actualizer
//
//  Created by Ryan Milvenan on 4/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActCustomCellView : UITableViewCell

/*
@property(nonatomic,strong)UIColor *whiteColor;
@property(nonatomic,strong)UIColor *goldColor;
@property(nonatomic,strong)UIColor *tanColor;
@property(nonatomic,strong)UIColor *separatorColor;
*/

@property(nonatomic,weak)IBOutlet UILabel *nameLabel;
@property(nonatomic,weak)IBOutlet UILabel *scoreLabel;

@end
