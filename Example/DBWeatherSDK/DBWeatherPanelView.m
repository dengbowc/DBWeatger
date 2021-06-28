//
//  DBWeatherPanelView.m
//  DBWeatherSDK_Example
//
//  Created by dengbo on 2021/6/28.
//  Copyright © 2021 dengbowc. All rights reserved.
//

#import "DBWeatherPanelView.h"

@interface DBWeatherPanelView ()

@property (nonatomic, strong) UILabel *maxTemC;
@property (nonatomic, strong) UILabel *maxTemK;
@property (nonatomic, strong) UILabel *minTemC;
@property (nonatomic, strong) UILabel *minTemK;
@property (nonatomic, strong) UILabel *city;
@property (nonatomic, strong) UILabel *time;

@end

@implementation DBWeatherPanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.maxTemC];
        [self addSubview:self.maxTemK];
        [self addSubview:self.minTemC];
        [self addSubview:self.minTemK];
        [self addSubview:self.city];
        [self addSubview:self.time];
    }
    return self;
}

- (void)setModel:(DBWeatherModel *)model {
    self.maxTemC.text = [NSString stringWithFormat:@"maxCelsuisTemperature: %.2f",model.maxCelsuisTemperature.doubleValue];
    self.maxTemK.text = [NSString stringWithFormat:@"maxKelvinTemperature: %@",model.maxKelvinTemperature];
    self.minTemC.text = [NSString stringWithFormat:@"minCelsuisTemperature: %.2f",model.minCelsuisTemperature.doubleValue];
    self.minTemK.text = [NSString stringWithFormat:@"minKelvinTemperature: %@",model.minKelvinTemperature];
    self.city.text = [NSString stringWithFormat:@"city: %@",model.city];
    self.time.text = [NSString stringWithFormat:@"date: %@",model.time];
}

- (UILabel *)city {
    if (!_city) {
        _city = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    }
    return _city;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 300, 30)];
    }
    return _time;
}

- (UILabel *)maxTemK {
    if (!_maxTemK) {
        _maxTemK = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 300, 30)];
    }
    return _maxTemK;
}

- (UILabel *)maxTemC {
    if (!_maxTemC) {
        _maxTemC = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 300, 30)];
    }
    return _maxTemC;
}

- (UILabel *)minTemK {
    if (!_minTemK) {
        _minTemK = [[UILabel alloc] initWithFrame:CGRectMake(15, 170, 300, 30)];
    }
    return _minTemK;
}

- (UILabel *)minTemC {
    if (!_minTemC) {
        _minTemC = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, 300, 30)];
    }
    return _minTemC;
}

@end
