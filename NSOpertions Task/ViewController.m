//
//  ViewController.m
//  NSOpertions Task
//
//  Created by Harish Singh on 16/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImage *image;
}
@property NSMutableArray *objects;
@property NSMutableArray *arrayForUsers;
@property (nonatomic, strong) NSOperationQueue *myQueue;
@end

@implementation ViewController

/**
 *  1. Get the number of users from UserInfo class and add it to a mutable array
 *  2. Get the loaded image from UserInfo class and add to a mutable array
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQueue = [[NSOperationQueue alloc] init];
    _userInfoController = [[UserInfoController alloc]init];
    self.arrayForUsers = _userInfoController.getUserName;
    self.objects = _userInfoController.getImageFromUrl;
    
    [_displayUserTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_displayUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
}

/**
 *  Load 10 more users and Url images on button click
 */
- (IBAction)loadMoreButton:(id)sender {
    _userInfoController.getRowCount;
    
    [_displayUserTableView reloadData];
    if([self.objects count] == 200) {
        _loadButton.enabled = NO;
        [_loadButton setTitle: @"Load Complete..." forState: UIControlStateNormal];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Method to get the minimum number of rows to display on table view at rumtime
 *
 *  @param theTableView is UITableView
 *
 *  @return minimum number of rows to display on table view
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

/**
 *  Method to get the maximum number of rows to display on table view at rumtime
 *
 *  @param theTableView is UITableView
 *
 *  @return maximum number of rows to display on table view
 */
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

/**
 *  Method to return a cell with downloaded image, User Name, time taken to load image and download complete image to the tableView
 *
 *  @param theTableView is UITableView
 *
 *  @return return a cell with downloaded image, User Name, time taken to load image and download complete image to the tableView
 */
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [_displayUserTableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell"];
    _startTime = _userInfoController.getCurrentTime;
    NSDate *object = self.objects[indexPath.row];
    cell.labelForUserName.text = [_userInfoController.getUserName objectAtIndex:indexPath.row];
    if([object valueForKey:@"status"]) {
        if([[object valueForKey:@"status"] isEqualToString:@"completed"] && [object valueForKey:@"image"] && [[object valueForKey:@"image"] isKindOfClass:[UIImage class]]) {
            cell.imageFromUrl.contentMode = UIViewContentModeScaleToFill;
            cell.imageFromUrl.image = [object valueForKey:@"image"];
            [cell.imageToCheckImageForUrlLoaded setImage:[UIImage imageNamed: @"tick19.png"]];
            
            _endTime = _userInfoController.getCurrentTime;
            NSTimeInterval timeDifference = [_endTime timeIntervalSinceDate:_startTime];
            NSString *stringForTime = @"Time taken: ";
            NSString *displayTimeDiff = [stringForTime stringByAppendingFormat:@"%f sec",timeDifference];
            
            cell.labelToShowTimeToLoadImage.text = displayTimeDiff;
            NSLog(@"%@",displayTimeDiff);
        }
    }
    else {
        [object setValue:@"inProgress" forKey:@"status"];
        [self.myQueue addOperationWithBlock:^{
            image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [object valueForKey:@"url"]]]];
            [object setValue:image forKey:@"image"];
            [object setValue:@"completed" forKey:@"status"];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_displayUserTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation: UITableViewRowAnimationRight];
            }];
  
        }];
    }
    return cell;
}

@end
