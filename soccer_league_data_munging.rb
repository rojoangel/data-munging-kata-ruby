require "./exceptions.rb"

class SmallestGoalDifferenceTeamCalculator
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestGoalDiffenceTeam, teamGoalData| if teamGoalData.goalDifference < smallestGoalDiffenceTeam.goalDifference then teamGoalData else smallestGoalDiffenceTeam end}.team
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
  def goalDifference
    @goals_for - @goals_against
  end
end
