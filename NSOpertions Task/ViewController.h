//
//  ViewController.h
//  NSOpertions Task
//
//  Created by Harish Singh on 16/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "DataSourceController.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *displayUserTableView;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageFromUrl;

@end

