//
//  Application.m
//  iShopper
//
//  Created by Zul on 9/9/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "Application.h"

@implementation Application

- (id)initWithPackageName:(NSString *)pn {
    
    self = [super init];
    
	if(self !=nil) {
     
        packageName = pn;
        
	}
	return self;

}

@end
