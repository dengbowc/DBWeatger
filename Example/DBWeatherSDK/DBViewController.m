//
//  DBViewController.m
//  DBWeatherSDK
//
//  Created by dengbowc on 06/25/2021.
//  Copyright (c) 2021 dengbowc. All rights reserved.
//

#import "DBViewController.h"
#import "DBWeatherModel.h"
#import "DBWeatherManager.h"
#import "DBWeatherPanelView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeiht [UIScreen mainScreen].bounds.size.height
#define ButtonWitdh 200
#define ButtonHeight 40

@interface DBViewController () <DBWeatherManagerDelegate>

@property (nonatomic, strong) DBWeatherManager *weatherManager;

@property (nonatomic, strong) DBWeatherPanelView *panelView;

@property (nonatomic, strong) UITextField *zipCodeInput;

@end

@implementation DBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    self.weatherManager = [DBWeatherManager new];
    self.weatherManager.delegate = self;
}

- (void)initView {
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 300) / 2, 100, 300, ButtonHeight)];
    [btn1 setTitle:@"Get current weather" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(getCurrentWeather) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.panelView];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 150, 230, ButtonHeight)];
    [btn2 setTitle:@"Get weather by zipcode" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:btn1];
    [btn2 addTarget:self action:@selector(getWeatherWithZipcode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.zipCodeInput];
    [self.view addSubview:btn2];
}

- (void)getCurrentWeather {
    [self.weatherManager getWeatherOfCurrentLocation];
}

- (void)getWeatherWithZipcode {
    [self.weatherManager getWeatherWithZipcode:self.zipCodeInput.text];
}

#pragma mark DBWeatherManagerDelegate
- (void)getWeatherFinished:(DBWeatherModel *)model error:(NSError *)error {
    if (model) {
        self.panelView.model = model;
    }else {
        // error tips
    }
}

- (DBWeatherPanelView *)panelView {
    if (!_panelView) {
        _panelView = [[DBWeatherPanelView alloc]initWithFrame:CGRectMake(0, 350, ScreenWidth, ScreenHeiht - 350)];
    }
    return _panelView;
}

- (UITextField *)zipCodeInput {
    if (!_zipCodeInput) {
        _zipCodeInput = [[UITextField alloc] initWithFrame:CGRectMake(15, 150, 100, ButtonHeight)];
        _zipCodeInput.placeholder = @"94040,us";
    }
    return _zipCodeInput;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.zipCodeInput resignFirstResponder];
}

@end
