//
//  DataSourceController.m
//  NSOpertions Task
//
//  Created by Harish Singh on 27/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "DataSourceController.h"

@implementation DataSourceController

/**
 *  Method to load the image path from url to dictionary and add it to a mutable array
 *
 *  @return the array with the dictionary of url paths
 */
-(id) init {
    DataSourceModel *dataModel = [[DataSourceModel alloc]init];
    
    dataModel.d1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_1.jpg",@"url", nil];
    dataModel.d2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_2.jpg",@"url", nil];
    dataModel.d3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_3.jpg",@"url", nil];
    dataModel.d4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_4.jpg",@"url", nil];
    dataModel.d5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_5.jpg",@"url", nil];
    dataModel.d6 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_6.jpg",@"url", nil];
    dataModel.d7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_7.jpg",@"url", nil];
    dataModel.d8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_8.jpg",@"url", nil];
    dataModel.d9 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_9.jpg",@"url", nil];
    dataModel.d10 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_10.jpg",@"url", nil];
    
    _arrayWithImage = [NSMutableArray arrayWithObjects:dataModel.d1,dataModel.d2,dataModel.d3,dataModel.d4,dataModel.d5,dataModel.d6,dataModel.d7,dataModel.d8,dataModel.d9,dataModel.d10,nil];
    return self;
}

@end
