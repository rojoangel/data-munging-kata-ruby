require "./weather_data_munging.rb"
require "test/unit"

class TestWeatherProcessor < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      WeatherDataProcessor.new.process(emptyData)
    end
  end
  def test_returns_day_from_single_day_weather_data
    weatherData = [DayWeatherData.new(1, 20, 30)]
    smallestTemperatureSpreadDay = WeatherDataProcessor.new.process(weatherData)
    assert_equal(1, smallestTemperatureSpreadDay)
  end
  def test_returns_smallest_temp_spread_day_from_multiple_day_weather_data
    weatherData = [DayWeatherData.new(1, 20, 30),
                   DayWeatherData.new(2, 17, 21),
                   DayWeatherData.new(3, 19, 31)]
    smallestTemperatureSpreadDay = WeatherDataProcessor.new.process(weatherData)
    assert_equal(2, smallestTemperatureSpreadDay)
  end
end
