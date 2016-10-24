require "./exceptions.rb"

class WeatherDataMunger
  def munge data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestTempSpreadDay, dayWeatherData| if dayWeatherData.tempStread < smallestTempSpreadDay.tempStread then dayWeatherData else smallestTempSpreadDay end}.day
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
  def tempStread
    @maxTemp - @minTemp
  end
end
