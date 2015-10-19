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
    
    
    NSMutableDictionary  *d1;
    NSMutableDictionary  *d2;
    NSMutableDictionary  *d3;
    NSMutableDictionary  *d4;
    NSMutableDictionary  *d5;
    NSMutableDictionary  *d6;
    NSMutableDictionary  *d7;
    NSMutableDictionary  *d8;
    NSMutableDictionary  *d9;
    NSMutableDictionary  *d10;
}
@property NSMutableArray *objects;
@property (nonatomic, strong) NSOperationQueue *myQueue;
@end

@implementation ViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    d1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_1.jpg",@"url", nil];
    d2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_2.jpg",@"url", nil];
    d3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_3.jpg",@"url", nil];
    d4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_4.jpg",@"url", nil];
    d5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_5.jpg",@"url", nil];
    d6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_6.jpg",@"url", nil];
    d7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_7.jpg",@"url", nil];
    d8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_8.jpg",@"url", nil];
    d9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_9.jpg",@"url", nil];
    d10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_10.jpg",@"url", nil];
    
    self.objects = [NSMutableArray arrayWithObjects:d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,nil];
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
}

- (NSArray *)subArrayForPageNumber:(NSUInteger)noOfRows{
     NSRange range = NSMakeRange(0, noOfRows);
    
    
//    NSRange range = NSMakeRange(_pageNumber*_numberOfVisibleRows, _numberOfVisibleRows);
//    if (range.location+range.length>[mainArray count]) {
//        range.length = [mainArray count]-range.location;
//    }
    return [mainArray subarrayWithRange:range];
}


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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [subArray count];
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_displayUserTableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ([self.objects count] < [subArray count]) {
        [self.objects addObject:d1];
        [self.objects addObject:d2];
        [self.objects addObject:d3];
        [self.objects addObject:d4];
        [self.objects addObject:d5];
        [self.objects addObject:d6];
        [self.objects addObject:d7];
        [self.objects addObject:d8];
        [self.objects addObject:d9];
        [self.objects addObject:d10];
    }
    
    NSDate *object = self.objects[indexPath.row];

    cell.textLabel.text = [subArray objectAtIndex:indexPath.row];
    
    if([object valueForKey:@"status"]) {
        if([[object valueForKey:@"status"] isEqualToString:@"completed"] && [object valueForKey:@"image"] && [[object valueForKey:@"image"] isKindOfClass:[UIImage class]]) {
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.imageView.image = [object valueForKey:@"image"];
        }
    }
    else {
        [object setValue:@"inProgress" forKey:@"status"];
        [self.myQueue addOperationWithBlock:^{
            UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString: [object valueForKey:@"url"]]]];
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
