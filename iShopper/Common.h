//
//  Common.h
//  iShopper
//
//  Created by Zul on 9/5/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

//password = vvv
//guid = 1dvi926lwg11s317mq1bpknuddfp1310080724;
//aiAccessToken = "104267018|v.kassin@informer.com|4786f3282f04de5b5c7317c490c6d922|aW5mb3JtZXIuY29t";

enum AuthorizeType {AUTH_NEW, AUTH_EXIST};

#define SERVICE_URL @"http://si.informer.com/si.iphone.php"
#define PACKAGE_ID @"bundleId"
#define KEY_ACCESSTOKEN @"accessToken"
#define KEY_GUID @"guid"

//auth types
#define SAUTH_NEW @"AI"
#define SAUTH_EXIST @"AIExist"

//json
#define JKEY_CODE @"code"
#define JKEY_ERRORCODE @"errorCode"
#define JKEY_ERRORMESSAGE @"errorMessage"
#define JKEY_GUID @"guid"
#define JKEY_USER @"user"
#define JKEY_ACCESSTOKEN @"aiAccessToken"
#define JKEY_APPLIST @"appList"

@interface Common : NSObject

+ (Common*) instance;

- (BOOL) authorizeWithEmail:(NSString*)mail andPassword:(NSString*)pass andType:(int)type;
- (BOOL) check_valid;
- (void) update;

- (void) sendNewToServer: (NSArray*) localApps;
- (BOOL) isAppOld:(NSString*) pn;

//- (void) detectApps;

@property (nonatomic, retain) NSMutableDictionary* dataFromServer;

@end

@interface NSData (DDData)

// gzip compression utilities
- (NSData *) gzipInflate;
- (NSData *) gzipDeflate;

@end