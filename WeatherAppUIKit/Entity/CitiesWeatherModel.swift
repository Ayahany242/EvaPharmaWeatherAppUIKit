//
//  CitiesResponseModel.swift
//  WeatherAppUIKit
//
//  Created by AYA on 22/07/2024.
//

import Foundation

struct CitiesWeatherModelElement: Codable {
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let currentUnits: CurrentUnits?
    let current: Current?
    let locationID: Int?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case locationID = "location_id"
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String?
    let interval: Int?
    let temperature2M: Double?
    let relativeHumidity2M: Int?
    let apparentTemperature: Double?
    let precipitation, weatherCode: Int?
    let rain: Float?
    let windSpeed: Float?
    let visibility:Float?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitation
        case weatherCode = "weather_code"
        case rain
        case windSpeed = "wind_speed_10m"
        case visibility = "visibility"
    }
}

// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time, interval, temperature2M, relativeHumidity2M: String?
    let apparentTemperature, precipitation, weatherCode,rain,windSpeedM,visibility: String?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitation
        case weatherCode = "weather_code"
        case rain
        case windSpeedM = "wind_speed_10m"
        case visibility = "visibility"

    }
}

typealias CitiesWeatherModel = [CitiesWeatherModelElement]

struct City{
    let cityName:String?
    let lat , long : Double?
}

struct CityCellData{
    let cityName:String?
    let weather: CitiesWeatherModelElement?
    var isFav:Bool?
}


import Foundation

enum WeatherCode: Int {
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    case fog = 45
    case depositingRimeFog = 48
    case lightDrizzle = 51
    case moderateDrizzle = 53
    case denseDrizzle = 55
    case lightFreezingDrizzle = 56
    case denseFreezingDrizzle = 57
    case slightRain = 61
    case moderateRain = 63
    case heavyRain = 65
    case lightFreezingRain = 66
    case heavyFreezingRain = 67
    case slightSnowFall = 71
    case moderateSnowFall = 73
    case heavySnowFall = 75
    case snowGrains = 77
    case slightRainShowers = 80
    case moderateRainShowers = 81
    case violentRainShowers = 82
    case slightSnowShowers = 85
    case heavySnowShowers = 86
    case slightThunderstorm = 95
    case thunderstormWithSlightHail = 96
    case thunderstormWithHeavyHail = 99

    var icon: String {
        switch self {
        case .clearSky:
            return "clear"
        case .mainlyClear, .partlyCloudy, .overcast:
            return "partly_cloudy"
        case .fog, .depositingRimeFog:
            return "Fog"
        case .lightDrizzle, .moderateDrizzle, .denseDrizzle,.lightFreezingDrizzle, .denseFreezingDrizzle:
            return "Drizzle"
        case .slightRain, .moderateRain, .heavyRain,.lightFreezingRain, .heavyFreezingRain,.slightRainShowers, .moderateRainShowers, .violentRainShowers:
            return "Rain"
        case .slightSnowFall, .moderateSnowFall, .heavySnowFall,.snowGrains:
            return "Snow"
        case .slightSnowShowers, .heavySnowShowers:
            return "Snow"
        case .slightThunderstorm:
            return "Cloudy"
        case .thunderstormWithSlightHail, .thunderstormWithHeavyHail:
            return "Cloudy"
        }
    }
}

class WeatherIcon {
   static func getIcon(for code: Int) -> String {
        guard let weatherCode = WeatherCode(rawValue: code) else {
            return "sunrise"
        }
        return weatherCode.icon
    }
}
