//
//  UserInfoController.m
//  NSOpertions Task
//
//  Created by Harish Singh on 27/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "UserInfoController.h"

@interface UserInfoController () {
    UIImage *imageForTick;
    int _numberOfVisibleRows;
}
@end

@implementation UserInfoController

/**
 *  Adding all 200 user names in usernames to UserInfo Class
 *
 */
-(id)init {
    _userInfo = [[UserInfo alloc] init];
    _userInfo.userName = [[NSMutableArray alloc]init];
    _userInfo.imageFromUrl = [[NSMutableArray alloc]init];
    NSUInteger rows = 0;
    while (rows<200) {
        [_userInfo.userName addObject:[NSString stringWithFormat:@"User-%lu",rows+1]];
        rows++;
    }
    _mainArray = [NSMutableArray arrayWithArray:_userInfo.userName];
    _numberOfVisibleRows = 10;
    return self;
}

/**
 *  Method to return 10 users in the array on each iteration
 *
 *  @param noOfRows is the rows to be displayed in UI
 *
 *  @return the array of 10 users on each iteration
 */
- (NSMutableArray *)subArrayForPageNumber:(int)noOfRows{
    NSRange range = NSMakeRange(0, noOfRows);
    return [_mainArray subarrayWithRange:range];
}

/**
 *  Method to get the User names
 *
 *  @return an array with user names
 */
-(NSMutableArray *) getUserName {
    if(_noOfRows == nil) {
        _subArray = [self subArrayForPageNumber: _numberOfVisibleRows];
        _noOfRows = [NSNumber numberWithInt:10];
    }
    else {
        _subArray = [self subArrayForPageNumber: [_noOfRows integerValue]];
    }
    return _subArray;
}

/**
 *  Method to store all the image urls to an Array of dictionary
 *
 *  @return array of dictionary having image url paths
 */
-(NSMutableArray *) getImageFromUrl {
    for (int i = 1; i<=10; i++) {
        [_userInfo.imageFromUrl addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"http://www.robots.ox.ac.uk/~vgg/research/flowers_demo/images/flower_%d.jpg",i], @"url", nil]];
    }
    return _userInfo.imageFromUrl;
}

///**
// *  Method to get all images for animation to show url image load status
// *
// *  @return an array of tick images
// */
//-(NSMutableArray *) getImageShowLoadingStatus {
//    _userInfo.imageForLoadingStatus = [[NSMutableArray alloc]init];
//    _userInfo.imageForLoadingStatus = [[NSMutableArray alloc]initWithCapacity:19];
//    imageForTick = [UIImage imageNamed: @"tick1.png"];
//    for (int i = 1; i<=19; i++) {
//        [_userInfo.imageForLoadingStatus addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tick%d",i]]];
//    }
//    return _userInfo.imageForLoadingStatus;
//}

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
 *  Method to add 10 more users and images on Load More button
 */
-(void)getRowCount {
    int rowCount = [_noOfRows integerValue];
    rowCount += 10;
    _noOfRows = [NSNumber numberWithInt:rowCount];
    [self getUserName];
    [self getImageFromUrl];
}

@end
