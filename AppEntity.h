//
//  AppEntity.h
//  iShopper
//
//  Created by Zul on 9/9/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppEntity : NSManagedObject

@property (nonatomic, retain) NSString * packageName;
@property (nonatomic, retain) NSString * name;

@end
