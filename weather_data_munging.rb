require "./exceptions.rb"

class WeatherDataProcessor
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestTempSpreadDay, dayWeatherData| if dayWeatherData.tempStread < smallestTempSpreadDay.tempStread then dayWeatherData else smallestTempSpreadDay end}.day
    end
  end
end

class WeatherDataMunger
  def munge data
    mungedData = []
    data.each_line do |line|
      if not(line.empty?) and not(line[0..4].strip.to_i == 0)
          day = line[0..4].strip.to_i
          maxTemp = line[5..8].strip.to_i
          minTemp = line[9..14].strip.to_i
          mungedData << DayWeatherData.new(day,minTemp,maxTemp)
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
  def tempStread
    @maxTemp - @minTemp
  end

  def <=>(other)
    if self.tempStread < other.tempStread
      -1
    elsif self.tempStread > other.tempStread
      1
    else
      0
    end
  end
end
