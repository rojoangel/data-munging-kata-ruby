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
  def test_parses_regular_line_containing_weather_data
    rawData = "  Dy MxT   MnT   AvT   HDDay  AvDP 1HrP TPcpn WxType PDir AvSp Dir MxS SkyC MxR MnR AvSLP\n" +
              "\n" +
              "   1  88    59    74          53.8       0.00 F       280  9.6 270  17  1.6  93 23 1004.5\n"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([DayWeatherData.new(1, 59, 88)], mungedData)
  end
  # next two tests work in ruby because the way strip_to_i works
  def test_parses_line_containing_weather_data_for_month_minimum #MnT marked with an '*'
    rawData = "   9  86    32*   59       6  61.5       0.00         240  7.6 220  12  6.0  78 46 1018.6"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([DayWeatherData.new(9, 32, 86)], mungedData)
  end
  def test_parses_line_containing_weather_data_for_month_maximum #MnT marked with an '*'
    rawData = "  26  97*   64    81          70.4       0.00 H       050  5.1 200  12  4.0 107 45 1014.9"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([DayWeatherData.new(26, 64, 97)], mungedData)
  end
  def test_ignores_month_summary_line
    rawData = "  mo  82.9  60.5  71.7    16  58.8       0.00              6.9          5.3"
    mungedData = WeatherDataMunger.new.munge(rawData)
    assert_equal([], mungedData)
  end
end
