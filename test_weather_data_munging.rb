require "./weather_data_munging.rb"
require "test/unit"

class TestWeatherDataProcessor < Test::Unit::TestCase
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

class TestWeatherDataMunger < Test::Unit::TestCase
  def test_ignores_header
    rawData = "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([], mungedData)
  end
  def test_ignores_empty_line
    rawData = "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP\n" +
              "\n"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([], mungedData)
  end
  def test_parses_line_containing_weather_data
    rawData = "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP\n" +
              "\n" +
              "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5\n"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([DayWeatherData.new(1, 59, 88)], mungedData)
  end
end
