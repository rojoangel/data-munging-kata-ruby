require "./exceptions.rb"

class WeatherDataProcessor
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestTempSpreadDay, dayWeatherData| if dayWeatherData.tempSpread < smallestTempSpreadDay.tempSpread then dayWeatherData else smallestTempSpreadDay end}.day
    end
  end
end

class WeatherDataMunger
  def munge data
    mungedData = []
    data.each_line do |line|
      unless line.empty?
        day = line[0..4].strip.to_i
        unless day == 0
          maxTemp = line[5..8].strip.to_i
          minTemp = line[9..14].strip.to_i
          mungedData << DayWeatherData.new(day,minTemp,maxTemp)
        end
      end
    end
    mungedData
  end
end

class DayWeatherData
  include Comparable

  attr_reader :day, :minTemp, :maxTemp

  def initialize(day, minTemp, maxTemp)
    @day = day
    @minTemp = minTemp
    @maxTemp = maxTemp
  end
  def tempSpread
    @maxTemp - @minTemp
  end

  def <=>(other)
    if self.tempSpread < other.tempSpread
      -1
    elsif self.tempSpread > other.tempSpread
      1
    else
      0
    end
  end
end
