//
//  ViewController.m
//  NSOpertions Task
//
//  Created by Harish Singh on 16/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    //pageNumber will hold the current page index
    NSInteger _pageNumber;
    //keeping the max page number for ease of calculation
    NSUInteger _maxPageNumber;
    //the batch size
    NSUInteger _numberOfVisibleRows;
    NSMutableArray *mainArray;
    NSMutableArray *subArray;
    
    NSMutableArray *tempArray;
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
    
   
    
    NSMutableDictionary  *d1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_1.jpg",@"url", nil];
    NSMutableDictionary  *d2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_2.jpg",@"url", nil];
    NSMutableDictionary  *d3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_3.jpg",@"url", nil];
    NSMutableDictionary  *d4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_4.jpg",@"url", nil];
    NSMutableDictionary  *d5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_5.jpg",@"url", nil];
    NSMutableDictionary  *d6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_6.jpg",@"url", nil];
    NSMutableDictionary  *d7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_7.jpg",@"url", nil];
    NSMutableDictionary  *d8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_8.jpg",@"url", nil];
    NSMutableDictionary  *d9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_9.jpg",@"url", nil];
    NSMutableDictionary  *d10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_10.jpg",@"url", nil];
    
    self.objects = [NSMutableArray arrayWithObjects:d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,nil];
    self.myQueue = [[NSOperationQueue alloc] init];
    
    tempArray = [[NSMutableArray alloc]init];
    NSUInteger rows = 0;
    while (rows<200) {
        [tempArray addObject:[NSString stringWithFormat:@"User-%lu",rows+1]];
        rows++;
    }
    
    mainArray = [NSArray arrayWithArray:tempArray];
    
    _pageNumber = 0;
    //_numberOfVisibleRows = 5;
    _numberOfVisibleRows = 10;
    _maxPageNumber = [mainArray count]/_numberOfVisibleRows;
    
    subArray = [self subArrayForPageNumber:_pageNumber];
}

- (NSArray *)subArrayForPageNumber:(NSUInteger)pageNumber{
   
    

    NSRange range = NSMakeRange(_pageNumber*_numberOfVisibleRows, _numberOfVisibleRows);
    if (range.location+range.length>[mainArray count]) {
        range.length = [mainArray count]-range.location;
    }
    return [mainArray subarrayWithRange:range];
}

- (IBAction)buttonPressed:(UIBarButtonItem *)button{
    //Same method is used for calculating the page numbers
    if (button.tag ==1) {
        _pageNumber= MIN(_maxPageNumber, _pageNumber+1);
    }else{
        _pageNumber = MAX(0, _pageNumber-1);
    }
    
    subArray = [self subArrayForPageNumber:_pageNumber];
    [_displayUserTableView reloadData];

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
    return [self.objects count];
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_displayUserTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDate *object = self.objects[indexPath.row];
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
    cell.textLabel.text = [subArray objectAtIndex:indexPath.row]; //[ NSString stringWithFormat:@"User %ld",(long)indexPath.row]; //[object valueForKey:@"url"];
    
       return cell;
}

@end
