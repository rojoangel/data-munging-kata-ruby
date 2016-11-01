require "./soccer_league_data_munging.rb"
require "test/unit"

class TestSmallestGoalDifferenceTeamCalculator < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      SmallestGoalDifferenceTeamCalculator.new.process(emptyData)
    end
  end
  def test_returns_team_from_single_team_goal_data
    goalData = [TeamGoalData.new("Arsenal", 36, 79)]
    smallestGoalDifferenceTeam = SmallestGoalDifferenceTeamCalculator.new.process(goalData)
    assert_equal("Arsenal", smallestGoalDifferenceTeam)
  end
  def test_returns_smallest_goal_difference_team_from_multiple_team_goal_data
    goalData = [TeamGoalData.new("Arsenal",      36, 79),
                TeamGoalData.new("Liverpool",    30, 67),
                TeamGoalData.new("Manchester_U", 45, 87)]
    smallestGoalDifferenceTeam = SmallestGoalDifferenceTeamCalculator.new.process(goalData)
    assert_equal("Liverpool", smallestGoalDifferenceTeam)
  end
end
