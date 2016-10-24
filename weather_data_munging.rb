require "./exceptions.rb"

class WeatherDataMunger
  def munge data
    if data.empty?
      raise Exceptions::EmptyData
    else
      1
    end
  end
end

class DayWeatherData
  attr_reader :day, :minTemp, :maxTemp
  def initialize(day, minTemp, maxTemp)
    @day = day
    @minTemp = minTemp
    @maxTemp = maxTemp
  end
end
