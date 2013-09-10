//
//  AppEntity.m
//  iShopper
//
//  Created by Zul on 9/9/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "AppEntity.h"


@implementation AppEntity

@dynamic packageName;
@dynamic name;

- (void)awakeFromInsert {

    AppEntity* ae = [[AppEntity MR_findAllSortedBy:@"appEntityID" ascending:YES] lastObject];
    NSNumber* count = [ae valueForKey:@"appEntityID"];
//    NSNumber *count = [AppEntity MR_numberOfEntities];
    [self setValue:[NSNumber numberWithInt:(count.intValue + 1)] forKey:@"appEntityID"];
    [super awakeFromInsert];
}
@end
