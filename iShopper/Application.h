//
//  Application.h
//  iShopper
//
//  Created by Zul on 9/9/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Application : NSObject {

    NSString* name;
    NSString* packageName;

}

- (id)initWithPackageName:(NSString *)pn;

@end
