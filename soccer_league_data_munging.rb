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

class SmallestGoalDifferenceTeamCalculator
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestDifferenceData, data| if data.difference < smallestDifferenceData.difference then data else smallestDifferenceData end}.label
    end
  end
end

class SoccerLeagueDataMunger
  def munge data
    mungedData = []
    data.each_line do |line|
      goals_for = line[39..44].strip.to_i
      unless goals_for == 0
        goals_against = line[48..51].strip.to_i
        team = line[7..22].strip
        mungedData << MungedData.new(team,goals_against,goals_for)
      end
    end
    mungedData
  end
end

class TeamGoalData
  include Comparable

  attr_reader :team, :goals_against, :goals_for

  def initialize(team, goals_against, goals_for)
    @team = team
    @goals_against = goals_against
    @goals_for = goals_for
  end
  def goalDifference
    (@goals_for - @goals_against).abs
  end

  def <=>(other)
    if self.goals_against < other.goals_against
      -1
    elsif self.goals_against > other.goals_against
      1
    elsif self.goals_for < other.goals_for
      -1
    elsif self.goals_for > other.goals_for
      1
    elsif self.team < other.team
      -1
    elsif self.team > other.team
      1
    else
      0
    end
  end
end
