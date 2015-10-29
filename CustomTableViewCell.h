//
//  CustomTableViewCell.h
//  NSOpertions Task
//
//  Created by Harish Singh on 26/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Properties declared for xib elements
 */
@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageFromUrl;
@property (weak, nonatomic) IBOutlet UILabel *labelForUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelToShowTimeToLoadImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageToCheckImageForUrlLoaded;

@end
