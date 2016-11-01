require "./exceptions.rb"

class SmallestGoalDifferenceTeamCalculator
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data[0].team
    end
  end
end

class TeamGoalData
  attr_reader :team, :against, :for

  def initialize(team, goals_against, goals_for)
    @team = team
    @goals_against = goals_against
    @goals_for = goals_for
  end
end
