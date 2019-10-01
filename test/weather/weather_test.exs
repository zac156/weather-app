defmodule WeatherWeb.WeatherTest do
  use ExUnit.Case

  test "transform" do
    input = %{
      "currently" => %{
        "apparentTemperature" => 16.47,
        "cloudCover" => 0.17,
        "dewPoint" => 9.18,
        "humidity" => 0.62,
        "icon" => "partly-cloudy-night",
        "nearestStormDistance" => 0,
        "ozone" => 343.9,
        "precipIntensity" => 0.0097,
        "precipProbability" => 0.03,
        "precipType" => "rain",
        "pressure" => 1018.75,
        "summary" => "Windy and Partly Cloudy",
        "temperature" => 16.47,
        "time" => 1_569_776_039,
        "uvIndex" => 0,
        "visibility" => 10.003,
        "windBearing" => 160,
        "windGust" => 14.13,
        "windSpeed" => 12.34
      },
      "daily" => %{
        "data" => [
          %{
            "windGustTime" => 1_569_762_000,
            "pressure" => 1015.49,
            "apparentTemperatureLowTime" => 1_569_812_400,
            "precipType" => "rain",
            "temperatureMaxTime" => 1_569_762_000,
            "ozone" => 337.3,
            "dewPoint" => 12.6,
            "temperatureLowTime" => 1_569_812_400,
            "precipIntensityMax" => 0.8774,
            "apparentTemperatureMaxTime" => 1_569_762_000,
            "apparentTemperatureMax" => 18.69,
            "apparentTemperatureHigh" => 18.69,
            "apparentTemperatureMin" => 14.91,
            "icon" => "rain",
            "temperatureLow" => 13.7,
            "uvIndexTime" => 1_569_751_200,
            "precipIntensity" => 0.1374,
            "visibility" => 11.11,
            "temperatureMin" => 14.91,
            "apparentTemperatureMinTime" => 1_569_794_400,
            "temperatureMinTime" => 1_569_794_400,
            "temperatureHighTime" => 1_569_762_000,
            "precipProbability" => 0.79,
            "temperatureHigh" => 18.69,
            "time" => 1_569_708_000,
            "windGust" => 22.06,
            "windSpeed" => 9.9,
            "apparentTemperatureHighTime" => 1_569_762_000,
            "cloudCover" => 0.39,
            "windBearing" => 165,
            "temperatureMax" => 18.69,
            "sunriseTime" => 1_569_731_251,
            "precipIntensityMaxTime" => 1_569_736_800,
            "moonPhase" => 0.04,
            "sunsetTime" => 1_569_775_701,
            "summary" => "Light rain in the morning.",
            "uvIndex" => 6,
            "apparentTemperatureLow" => 13.7,
            "humidity" => 0.79
          },
          %{
            "windGustTime" => 1_569_794_400,
            "pressure" => 1023.16,
            "apparentTemperatureLowTime" => 1_569_895_200,
            "precipType" => "rain",
            "temperatureMaxTime" => 1_569_844_800,
            "ozone" => 326.7,
            "dewPoint" => 11.57,
            "temperatureLowTime" => 1_569_895_200,
            "precipIntensityMax" => 0.0449,
            "apparentTemperatureMaxTime" => 1_569_844_800,
            "apparentTemperatureMax" => 21.02,
            "apparentTemperatureHigh" => 21.02,
            "apparentTemperatureMin" => 13.7,
            "icon" => "partly-cloudy-day",
            "temperatureLow" => 13.95,
            "uvIndexTime" => 1_569_837_600,
            "precipIntensity" => 0.0106,
            "visibility" => 16.093,
            "temperatureMin" => 13.7,
            "apparentTemperatureMinTime" => 1_569_812_400,
            "temperatureMinTime" => 1_569_812_400,
            "temperatureHighTime" => 1_569_844_800,
            "precipProbability" => 0.11,
            "temperatureHigh" => 21.02,
            "time" => 1_569_794_400,
            "windGust" => 10.24,
            "windSpeed" => 5.11,
            "apparentTemperatureHighTime" => 1_569_844_800,
            "cloudCover" => 0.14,
            "windBearing" => 168,
            "temperatureMax" => 21.02,
            "sunriseTime" => 1_569_817_568,
            "precipIntensityMaxTime" => 1_569_812_400,
            "moonPhase" => 0.08,
            "sunsetTime" => 1_569_862_143,
            "summary" => "Partly cloudy throughout the day.",
            "uvIndex" => 5,
            "apparentTemperatureLow" => 13.95,
            "humidity" => 0.72
          }
        ]
      }
    }

    output = %{
      "daily" => [
        %{
          "date" => ~D[2019-09-28],
          "description" => "Light rain in the morning.",
          "temperature" => %{"high" => 18.69, "low" => 13.7},
          "type" => "rain"
        },
        %{
          "date" => ~D[2019-09-29],
          "description" => "Partly cloudy throughout the day.",
          "temperature" => %{"high" => 21.02, "low" => 13.95},
          "type" => "partly-cloudy-day"
        }
      ],
      "date" => ~D[2019-09-29],
      "description" => "Windy and Partly Cloudy",
      "precip_prob" => 0.03,
      "temperature" => 16.47,
      "type" => "partly-cloudy-night",
      "wind" => %{"bearing" => 160, "speed" => 12.34}
    }

    assert Weather.transform(input) == output
  end

  test "transform daily" do
    input = %{
      "windGustTime" => 1_569_762_000,
      "pressure" => 1015.49,
      "apparentTemperatureLowTime" => 1_569_812_400,
      "precipType" => "rain",
      "temperatureMaxTime" => 1_569_762_000,
      "ozone" => 337.3,
      "dewPoint" => 12.6,
      "temperatureLowTime" => 1_569_812_400,
      "precipIntensityMax" => 0.8774,
      "apparentTemperatureMaxTime" => 1_569_762_000,
      "apparentTemperatureMax" => 18.69,
      "apparentTemperatureHigh" => 18.69,
      "apparentTemperatureMin" => 14.91,
      "icon" => "rain",
      "temperatureLow" => 13.7,
      "uvIndexTime" => 1_569_751_200,
      "precipIntensity" => 0.1374,
      "visibility" => 11.11,
      "temperatureMin" => 14.91,
      "apparentTemperatureMinTime" => 1_569_794_400,
      "temperatureMinTime" => 1_569_794_400,
      "temperatureHighTime" => 1_569_762_000,
      "precipProbability" => 0.79,
      "temperatureHigh" => 18.69,
      "time" => 1_569_708_000,
      "windGust" => 22.06,
      "windSpeed" => 9.9,
      "apparentTemperatureHighTime" => 1_569_762_000,
      "cloudCover" => 0.39,
      "windBearing" => 165,
      "temperatureMax" => 18.69,
      "sunriseTime" => 1_569_731_251,
      "precipIntensityMaxTime" => 1_569_736_800,
      "moonPhase" => 0.04,
      "sunsetTime" => 1_569_775_701,
      "summary" => "Light rain in the morning.",
      "uvIndex" => 6,
      "apparentTemperatureLow" => 13.7,
      "humidity" => 0.79
    }

    output = %{
      "date" => ~D[2019-09-28],
      "description" => "Light rain in the morning.",
      "temperature" => %{"high" => 18.69, "low" => 13.7},
      "type" => "rain"
    }

    assert Weather.transform_daily(input) == output
  end

  test "transform_time_to_date" do
    assert Weather.transform_time_to_date(1_569_772_800) == ~D[2019-09-29]
  end
end
