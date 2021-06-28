//
//  DBNetworkManager.m
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import "DBNetworkManager.h"

@implementation DBNetworkManager

+ (instancetype)sharedInstance {
    static DBNetworkManager * _ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ins = [[self alloc] init];
    });
    return _ins;
}

- (void)requestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail {
    
    NSMutableString *strM = [[NSMutableString alloc] init];
   
    [paramaters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        NSString *paramaterKey = key;
        NSString *paramaterValue = obj;
        [strM appendFormat:@"%@=%@&",paramaterKey,paramaterValue];
    }];
   
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,strM];
   
    urlString = [urlString substringToIndex:urlString.length - 1];
   
    NSLog(@"urlString:%@",urlString);
   
    NSURL *url = [NSURL URLWithString:urlString];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
   
    // 2. send request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
       
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
       
        if (data && !error) {
            // check json
            // JSON parsing.
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
           
            if (!obj) {
                obj = data;
            }
            // success handler on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(obj,response);
                }
            });
           
        }else
        {
            if (fail) {
                fail(error);
            }
        }
    }] resume];
}

@end
