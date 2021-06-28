//
//  DBNetworkManager.h
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id object , NSURLResponse *response);
typedef void(^failBlock)(NSError *error);

@interface DBNetworkManager : NSObject

+ (instancetype)sharedInstance;

-(void)requestWithUrl:(NSString *)urlString paramaters:(NSMutableDictionary *)paramaters successBlock:(SuccessBlock)success FailBlock:(failBlock)fail;

@end

