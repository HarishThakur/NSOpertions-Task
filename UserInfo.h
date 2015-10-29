//
//  UserInfo.h
//  NSOpertions Task
//
//  Created by Harish Singh on 27/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Model class to set properties of User information
 */
@interface UserInfo : NSObject

@property (strong, nonatomic) NSMutableArray *userName;
@property (strong,nonatomic) NSMutableArray *imageFromUrl;
@property (strong,nonatomic) NSMutableArray *imageForLoadingStatus;
@property (strong, nonatomic) NSString *timeTakenToLoadImage;

@end
