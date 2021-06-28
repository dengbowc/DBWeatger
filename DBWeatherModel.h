//
//  DBWeatherModel.h
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import <Foundation/Foundation.h>


@interface DBWeatherModel : NSObject

// temprature of Celsuis
@property (nonatomic, strong) NSNumber *maxCelsuisTemperature;
@property (nonatomic, strong) NSNumber * minCelsuisTemperature;

// temprature of Kelvin
@property (nonatomic, strong) NSNumber * maxKelvinTemperature;
@property (nonatomic, strong) NSNumber * minKelvinTemperature;

// the city of your zipcode
@property (nonatomic, strong) NSString *city;

// the time that you requested with formmat yyyy-MM-dd
@property (nonatomic, strong) NSString *time;

+ (instancetype)weatherModelWithData:(NSDictionary *)json;

@end

