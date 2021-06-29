//
//  DBWeatherManager.h
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DBWeatherError) {
    DBWeatherZipcodeError,
    DBWeatherNetworkError,
    DBWeatherJsonParseError,
    DBWeatherLocationError,
    DBWeatherUnknownError
};

@class DBWeatherModel;

@protocol DBWeatherManagerDelegate <NSObject>

@optional

- (void)getWeatherFinished:(DBWeatherModel *)model error:(NSError *)error;

@end

@interface DBWeatherManager : NSObject

@property (nonatomic, weak) id <DBWeatherManagerDelegate> delegate;

/*
 get the weather of your current location
 */
- (void)getWeatherOfCurrentLocation;

/*
 get the weather of your input zipcode,if none,use your location zipcode instead.
 */
- (void)getWeatherWithZipcode:(NSString *)zipCode;

@end

