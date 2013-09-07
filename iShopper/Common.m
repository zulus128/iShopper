//
//  Common.m
//  iShopper
//
//  Created by Zul on 9/5/13.
//  Copyright (c) 2013 Zul. All rights reserved.
//

#import "Common.h"
#import "zlib.h"

@implementation Common

+ (Common*) instance  {
	
	static Common* instance;
	
	@synchronized(self) {
		
		if(!instance) {
			
			instance = [[Common alloc] init];
            
		}
	}
	return instance;
}

- (id) init {
	
	self = [super init];
	if(self !=nil) {
        
	}
	return self;
}

- (void) sendToServer: (NSDictionary*) values {

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:values
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        
        NSLog(@"Got an error: %@", error);
        return;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"Sending: %@", jsonString);
    
    NSData *postData1 = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSData *postData = [postData1 gzipDeflate];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:SERVICE_URL]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"; filename=\"%@\"\r\n", @"data"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:postData]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postbody length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLResponse *response;
    NSData *POSTReply1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSData *POSTReply = [POSTReply1 gzipInflate];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"Reply: %@", theReply);
    

}

- (void) authorize {

    NSMutableDictionary* dictionaryToOutput = [NSMutableDictionary dictionary];
    [dictionaryToOutput setObject:@"authorize" forKey:@"mode"];
    [dictionaryToOutput setObject:@"vkassin@mail.ru" forKey:@"email"];
    [dictionaryToOutput setObject:@"AI" forKey:@"authServiceName"];
    [dictionaryToOutput setObject:@"pass" forKey:@"password"];
    [dictionaryToOutput setObject:@"Test User" forKey:@"name"];
    [dictionaryToOutput setObject:@"e8obrez9k1" forKey:@"deviceData"];
    [dictionaryToOutput setObject:[NSNumber numberWithInt:1] forKey:@"buildNum"];

    NSMutableDictionary* systemInfo = [NSMutableDictionary dictionary];
    [systemInfo setObject:@"GT-P7300" forKey:@"deviceModel"];
    [systemInfo setObject:@"samsung" forKey:@"manufacturer"];
    [systemInfo setObject:@"3.1" forKey:@"androidVersion"];
    [systemInfo setObject:[NSNumber numberWithInt:1280] forKey:@"displayH"];
    [systemInfo setObject:[NSNumber numberWithInt:800] forKey:@"displayW"];
    [systemInfo setObject:[NSNumber numberWithFloat:1.0f] forKey:@"displayDensity"];

    [dictionaryToOutput setObject:systemInfo forKey:@"systemInfo"];

    [self sendToServer:dictionaryToOutput];
}

- (void) check_valid {

    NSMutableDictionary* dictionaryToOutput = [NSMutableDictionary dictionary];
    [dictionaryToOutput setObject:@"check_valid" forKey:@"mode"];
    [dictionaryToOutput setObject:@"104267017|vkassin@mail.ru|pass|aW5mb3JtZXIuY29t" forKey:@"aiAccessToken"];
    [dictionaryToOutput setObject:@"1dvi926lwg11s317mq1bpknuddfp1309071519" forKey:@"guid"];
    [dictionaryToOutput setObject:[NSNumber numberWithInt:1] forKey:@"buildNum"];

    [self sendToServer:dictionaryToOutput];

}

- (void) update {
    
    NSMutableDictionary* dictionaryToOutput = [NSMutableDictionary dictionary];
    [dictionaryToOutput setObject:@"update" forKey:@"mode"];
    [dictionaryToOutput setObject:@"104267017|vkassin@mail.ru|pass|aW5mb3JtZXIuY29t" forKey:@"aiAccessToken"];
    [dictionaryToOutput setObject:@"1dvi926lwg11s317mq1bpknuddfp1309071519" forKey:@"guid"];
    [dictionaryToOutput setObject:[NSNumber numberWithInt:1] forKey:@"buildNum"];
    
    [self sendToServer:dictionaryToOutput];
    
}

@end

@implementation NSData (DDData)

- (NSData *)gzipInflate {
    
    if ([self length] == 0) return self;
    
    unsigned full_length = [self length];
    unsigned half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = [self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}

- (NSData *)gzipDeflate {
    
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[self bytes];
    strm.avail_in = [self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = [compressed length] - strm.total_out;
        
        deflate(&strm, Z_FINISH);  
        
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}

@end
