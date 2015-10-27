//
//  CustomTableViewCell.m
//  NSOpertions Task
//
//  Created by Harish Singh on 26/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)init{
    
    NSLog(@"Loading Custom Cell");
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
