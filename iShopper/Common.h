//
//  Common.h
//  iShopper
//
//  Created by Zul on 9/5/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#define SERVICE_URL @"http://si.informer.com/si.iphone.php"

@interface Common : NSObject

+ (Common*) instance;

- (void) authorize;
- (void) check_valid;
- (void) update;

- (BOOL) isAppOld:(NSString*) pn;

//- (void) detectApps;

@property (nonatomic, retain) NSDictionary* dataFromServer;

@end

@interface NSData (DDData)

// gzip compression utilities
- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

@end