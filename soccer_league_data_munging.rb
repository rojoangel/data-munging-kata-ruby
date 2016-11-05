require "./exceptions.rb"
require "./data_munging.rb"

class SoccerLeagueDataProcessor
  def initialize(fileReader,
                 dataMunger,
                 smallestGoalDifferenceTeamCalculator)
    @fileReader = fileReader
    @dataMunger = dataMunger
    @smallestGoalDifferenceTeamCalculator = smallestGoalDifferenceTeamCalculator
  end
  def calculateTeamWithSmallestGoalDifference
    contents = @fileReader.read
    data = @dataMunger.munge(contents)
    @smallestGoalDifferenceTeamCalculator.process(data)
  end
end

class SoccerLeagueDataMunger
  def munge data
    mungedData = []
    data.each_line do |line|
      unless line.empty?
        goals_for = line[39..44].strip.to_i
        unless goals_for == 0
          goals_against = line[48..51].strip.to_i
          team = line[7..22].strip
          mungedData << MungedData.new(team,goals_against,goals_for)
        end
      end
    end
    mungedData
  end
end
