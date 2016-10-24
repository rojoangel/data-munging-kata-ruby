require "./weather_data_munging.rb"
require "test/unit"

class TestWeatherMunger < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      WeatherDataMunger.new.munge(emptyData)
    end
  end
end
