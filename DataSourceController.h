//
//  DataSourceController.h
//  NSOpertions Task
//
//  Created by Harish Singh on 27/10/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceModel.h"


@interface DataSourceController : NSObject

@property DataSourceModel *dataSource;

@property (strong,nonatomic) NSMutableArray *arrayWithImage;

@end
