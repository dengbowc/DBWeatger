# DBWeatherSDK

## Summary
I made this SDK and test example project via cocoapods directly.See details below.

## API Description

###Public headers

####DBWeatherManager

Two interfaces are provided, one is used to obtain the weather directly (- getWeatherOfCurrentLocation), and the other is based on zipcode (- getWeatherWithZipcode:).Handle the result to callers using delegate pattern.

####DBWeatherModel

A datastructure describe the weather,include temperature(both Kelvin and Celsius) and city,date informations.

## Patterns Usage
Delegate Sington MVC

## Package and Distribution


## Example

Run the example project, you can see two buttons on the home screen that will trigger the two weather api in DBWeatherManager,get weather model and show in a panel view.

## Installation

DBWeatherSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DBWeatherSDK'
```

## Author

dengbowc, dengbowc@gmail.com

## License

DBWeatherSDK is available under the MIT license. See the LICENSE file for more info.
