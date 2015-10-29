//
//  ViewController.h
//  NSOpertions Task
//
//  Created by Harish Singh on 16/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "UserInfoController.h"


/**
 *  View:
 *  Declared properties to load the view
 */
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *displayUserTableView;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageFromUrl;

@property UserInfoController *userInfoController;

@property (strong, nonatomic) NSDate *startTime;
@property (strong, nonatomic) NSDate *endTime;



@end

