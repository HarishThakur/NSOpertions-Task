//
//  UserInfoController.h
//  NSOpertions Task
//
//  Created by Harish Singh on 27/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UserInfo.h"

/**
 *  Controller: Declared the properties and methods to fetch User Information
 */
@interface UserInfoController : NSObject

@property (strong,nonatomic) NSMutableArray *mainArray;
@property (strong,nonatomic) NSMutableArray *subArray;
@property (strong,nonatomic) NSNumber *noOfRows;
@property UserInfo *userInfo;
-(NSMutableArray *) getUserName;
-(NSMutableArray *) getImageFromUrl;
-(NSMutableArray *) getImageShowLoadingStatus;
-(NSDate *) getCurrentTime;
-(void)getRowCount;

@end
