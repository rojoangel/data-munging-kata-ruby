require "./exceptions.rb"
require "./data_munging.rb"

class WeatherDataProcessor
  def initialize(fileReader,
                 dataMunger,
                 minimumDailyTemperatureSpreadCalculator)
    @fileReader = fileReader
    @dataMunger = dataMunger
    @minimumDailyTemperatureSpreadCalculator = minimumDailyTemperatureSpreadCalculator
  end
  def calculateDayWithMinimumTemperatureSpread
    contents = @fileReader.read
    data = @dataMunger.munge(contents)
    @minimumDailyTemperatureSpreadCalculator.process(data)
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
          mungedData << MungedData.new(day,minTemp,maxTemp)
        end
      end
    end
    mungedData
  end
end
