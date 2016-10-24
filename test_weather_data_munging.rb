require "./weather_data_munging.rb"
require "test/unit"

class TestWeatherMunger < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      WeatherDataMunger.new.munge(emptyData)
    end
  end
  def test_returns_day_from_single_day_weather_data
    weatherData = [DayWeatherData.new(1, 20, 30)]
    smallestTemperatureSpreadDay = WeatherDataMunger.new.munge(weatherData)
    assert_equal(1, smallestTemperatureSpreadDay)
  end
  def test_returns_smallest_temp_spread_day_from_multiple_day_weather_data
    weatherData = [DayWeatherData.new(1, 20, 30),
                   DayWeatherData.new(2, 17, 21),
                   DayWeatherData.new(3, 19, 31)]
    smallestTemperatureSpreadDay = WeatherDataMunger.new.munge(weatherData)
    assert_equal(2, smallestTemperatureSpreadDay)
  end
end
