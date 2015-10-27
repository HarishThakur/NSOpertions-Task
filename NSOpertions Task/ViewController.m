//
//  ViewController.m
//  NSOpertions Task
//
//  Created by Harish Singh on 16/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    //the batch size
    NSUInteger _numberOfVisibleRows;
    NSMutableArray *mainArray;
    NSMutableArray *subArray;
    NSMutableArray *tempArray;
    UIImage *image;
    NSMutableArray *imageArray;
}
@property NSMutableArray *objects;
@property (nonatomic, strong) NSOperationQueue *myQueue;
@end

@implementation ViewController

/**
 *  1. Get the loaded image from URL to a mutable array
 *  2. Initialized NSOperationQueue
 *  3. Loaded 200 Users in temparray
 *  4. Added 10 Users in subarray to display in table view
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_displayUserTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_displayUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CustomTableViewCell"];

    DataSourceController *data = [[DataSourceController alloc]init];
    self.objects = data.arrayWithImage;
    
    self.myQueue = [[NSOperationQueue alloc] init];
    
    tempArray = [[NSMutableArray alloc]init];
    NSUInteger rows = 0;
    while (rows<200) {
        [tempArray addObject:[NSString stringWithFormat:@"User-%lu",rows+1]];
        rows++;
    }

    mainArray = [NSArray arrayWithArray:tempArray];
    _numberOfVisibleRows = 10;
    subArray = [self subArrayForPageNumber: _numberOfVisibleRows];
    _displayUserTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/**
 *  Getting 10 Users to mainArray
 *
 *  @param noOfRows is returning 10 each time
 *
 *  @return 10 Users
 */
- (NSArray *)subArrayForPageNumber:(NSUInteger)noOfRows{
     NSRange range = NSMakeRange(0, noOfRows);
    return [mainArray subarrayWithRange:range];
}

/**
 *  Load 10 more users on button click
 */
- (IBAction)loadMoreButton:(id)sender {
    subArray = [self subArrayForPageNumber:_numberOfVisibleRows+10];
    [_displayUserTableView reloadData];
    _numberOfVisibleRows = _numberOfVisibleRows+10;
    if([subArray count] == 200) {
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
    return [subArray count];
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
    
    if ([self.objects count] < [subArray count]) {
        [self.objects addObjectsFromArray:self.objects];
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"mm:ss:SS"];
    NSDate *today = [NSDate date];
    NSDate* firstDate = today;
    
    NSDate *object = self.objects[indexPath.row];

    cell.labelForUserName.text = [subArray objectAtIndex:indexPath.row];

    if([object valueForKey:@"status"]) {
        if([[object valueForKey:@"status"] isEqualToString:@"completed"] && [object valueForKey:@"image"] && [[object valueForKey:@"image"] isKindOfClass:[UIImage class]]) {
            cell.imageFromUrl.contentMode = UIViewContentModeScaleToFill;
            cell.imageFromUrl.image = [object valueForKey:@"image"];
            imageArray = [[NSMutableArray alloc]initWithCapacity:19];
                       image = [UIImage imageNamed: @"tick1.png"];
            [cell.imageToCheckImageForUrlLoaded setImage:image];
            
            NSDate *today = [NSDate date];
            NSDate* secondDate = today;
            NSTimeInterval timeDifference = [secondDate timeIntervalSinceDate:firstDate];
            NSString *stringForTime = @"Time taken: ";
            NSString *test = [stringForTime stringByAppendingFormat:@"%f sec",timeDifference];
            
            cell.labelToShowTimeToLoadImage.text = test;
            NSLog(@"%@",test);
            
            for (int i = 1; i <= 19; i++) {
                [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tick%d",i]]];
                cell.imageToCheckImageForUrlLoaded.animationImages = [NSArray arrayWithArray:imageArray];
                cell.imageToCheckImageForUrlLoaded.animationDuration = 1;
                cell.imageToCheckImageForUrlLoaded.animationRepeatCount = 1;
                [cell.imageToCheckImageForUrlLoaded startAnimating];
                [cell.imageToCheckImageForUrlLoaded setImage:[UIImage imageNamed: @"tick19.png"]];
            }
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
