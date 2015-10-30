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
@property (nonatomic, strong) NSOperationQueue *myQueue;
@end

@implementation ViewController

/**
 *  1. Get the number of users from and images in an array
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myQueue = [[NSOperationQueue alloc] init];
    _arrayForUserInformation = [[NSMutableArray alloc]init];
    [self getUserInformation];
    [_displayUserTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_displayUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];
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
    return [_arrayForUserInformation count];
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
    _userInfo = [_arrayForUserInformation objectAtIndex:indexPath.row];
    __weak CustomTableViewCell *cell = [_displayUserTableView dequeueReusableCellWithIdentifier:@"CustomTableViewCell"];
    
    cell.labelForUserName.text = _userInfo.userName1;
    _startTime = [self getCurrentTime];
     [self.myQueue addOperationWithBlock:^{
         NSURL *url = [NSURL URLWithString:_userInfo.imageFromUrl1];
         NSData *data = [NSData dataWithContentsOfURL:url];
         image = nil;
         if(data)
         image = [UIImage imageWithData:data];
    
         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             cell.imageFromUrl.image = image;
             cell.imageFromUrl.contentMode = UIViewContentModeScaleToFill;
             cell.imageToCheckImageForUrlLoaded.image = [UIImage imageNamed:@"tick19.png"];
             _endTime = [self getCurrentTime];
             NSTimeInterval timeDifference = [_endTime timeIntervalSinceDate:_startTime];
             NSString *stringForTime = @"Time taken: ";
             NSString *displayTimeDiff = [stringForTime stringByAppendingFormat:@"%f sec",timeDifference];
             cell.labelToShowTimeToLoadImage.text = displayTimeDiff;
             NSLog(@"%@",displayTimeDiff);
         }];
         
    }];
    return cell;
}

/**
 *  Method to return 10 User and ImageFromUrl in mutable array
 *
 *  @return return 10 User and ImageFromUrl to UserInfo Class in mutable array
 */
-(NSMutableArray *) getUserInformation {
    
    for (int i = 1; i<=10; i++) {
        _userInfo = [[UserInfo alloc]init];
        _userInfo.userName1 = [NSString stringWithFormat:@"User-%d",i];
        _userInfo.imageFromUrl1 = [NSString stringWithFormat:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_%d.jpg",i];
        [_arrayForUserInformation addObject:_userInfo];
    }
    return _arrayForUserInformation;
}

/**
 *  Method to return current time
 *
 *  @return current time
 */
-(NSDate *) getCurrentTime {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"mm:ss:SS"];
    NSDate *today = [NSDate date];
    NSDate* currentTime = today;
    return currentTime;
}

/**
 *  Load 10 more users and Url images on button click
 */
- (IBAction)loadMoreButton:(id)sender {
    [self getUserInformation];
    [_displayUserTableView reloadData];
}

@end
