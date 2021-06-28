//
//  DBWeatherModel.m
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import "DBWeatherModel.h"

@implementation DBWeatherModel

+ (instancetype)weatherModelWithData:(NSDictionary *)json {
    DBWeatherModel *model = [DBWeatherModel new];
    model.city = json[@"name"];
    model.maxKelvinTemperature = json[@"main"][@"temp_max"];
    model.minKelvinTemperature = json[@"main"][@"temp_min"];
    
    NSString *timeStamp = json[@"dt"];
    
    model.time = [self UTCchangeDate:timeStamp];
    return model;
}


+ (NSString *)UTCchangeDate:(NSString *)utc {
    NSTimeInterval time = [utc doubleValue];

    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];

    [dateformatter setDateFormat:@"yyyy-MM-dd"];

    NSString *staartstr=[dateformatter stringFromDate:date];

    return staartstr;
}

- (NSNumber *)maxCelsuisTemperature {
    CGFloat cTem = self.maxKelvinTemperature.doubleValue - 273.15;
    return @(cTem);
}

- (NSNumber *)minCelsuisTemperature {
    CGFloat cTem = self.minKelvinTemperature.doubleValue - 273.15;
    return @(cTem);
}

@end
