//
//  DBWeatherManager.m
//  DBWeatherSDK
//
//  Created by dengbo on 2021/6/25.
//

#import "DBWeatherManager.h"
#import "DBWeatherModel.h"
#import <DBNetworkManager.h>
#import <CoreLocation/CoreLocation.h>

@interface DBWeatherManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation DBWeatherManager

- (void)getWeatherOfCurrentLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)getWeatherWithZipcode:(NSString *)zipCode {
    if (![zipCode isKindOfClass:[NSString class]] || [zipCode length] <= 0) {
        zipCode = @"94040,us";
//        if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
//            [self.delegate getWeatherFinished:nil error:[self createErrorWithType:DBWeatherZipcodeError]];
//        }
//        return;
    }
    [[DBNetworkManager sharedInstance] requestWithUrl:@"https://api.openweathermap.org/data/2.5/weather" paramaters:@{@"zip":zipCode, @"appid" : @"edfe4ace41a2a8b1b9c7b15885662313"}.mutableCopy successBlock:^(id object, NSURLResponse *response) {
        if ([object isKindOfClass:[NSDictionary class]]) {
            DBWeatherModel *model = [DBWeatherModel weatherModelWithData:object];
            if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
                [self.delegate getWeatherFinished:model error:nil];
            }
        }else {
            if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
                [self.delegate getWeatherFinished:nil error:[self createErrorWithType:DBWeatherJsonParseError]];
            }
        }
    } FailBlock:^(NSError *error) {
        if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
            [self.delegate getWeatherFinished:nil error:error];
        }
    }];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
            [self.delegate getWeatherFinished:nil error:[self createErrorWithType:DBWeatherLocationError]];
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        if ([self.delegate respondsToSelector:@selector(getWeatherFinished:error:)]) {
            [self.delegate getWeatherFinished:nil error:[self createErrorWithType:DBWeatherLocationError]];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            [self getWeatherWithZipcode:placemark.postalCode];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    [manager stopUpdatingLocation];
}
- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [_locationManager requestAlwaysAuthorization];
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

NSString *const DBWeatherErrorMsgKey = @"msg";
- (NSError *)createErrorWithType:(DBWeatherError)errorCode {
    
    NSDictionary *userInfo = nil;
    
    switch (errorCode) {
        case DBWeatherZipcodeError:
            userInfo = @{DBWeatherErrorMsgKey:@"U have pass error zipcode"};
            break;
        case DBWeatherNetworkError:
            userInfo = @{DBWeatherErrorMsgKey:@"There's something wrong with your network"};
            break;
        case DBWeatherJsonParseError:
            userInfo = @{DBWeatherErrorMsgKey:@"Bad data returned"};
            break;
        case DBWeatherLocationError:
            userInfo = @{DBWeatherErrorMsgKey:@"The location service is disabled"};
            break;
        default:
            userInfo = @{DBWeatherErrorMsgKey:@"Unkown Error~"};
            break;
    }
    
    return [NSError errorWithDomain:@"DBWeatherManager" code:errorCode userInfo:userInfo];
}

@end
