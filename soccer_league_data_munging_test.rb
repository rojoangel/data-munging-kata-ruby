require "./soccer_league_data_munging.rb"
require "test/unit"

class TestSmallestDifferenceCalculatorWithTeamGoalData < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      SmallestDifferenceCalculator.new.process(emptyData)
    end
  end
  def test_returns_team_from_single_team_goal_data
    goalData = [MungedData.new("Arsenal", 36, 79)]
    smallestGoalDifferenceTeam = SmallestDifferenceCalculator.new.process(goalData)
    assert_equal("Arsenal", smallestGoalDifferenceTeam)
  end
  def test_returns_smallest_goal_difference_team_from_multiple_team_goal_data
    goalData = [MungedData.new("Arsenal",      36, 79),
                MungedData.new("Liverpool",    30, 67),
                MungedData.new("Manchester_U", 45, 87)]
    smallestGoalDifferenceTeam = SmallestDifferenceCalculator.new.process(goalData)
    assert_equal("Liverpool", smallestGoalDifferenceTeam)
  end
end

class TestSoccerLeagueDataMunger < Test::Unit::TestCase
  def test_ignores_lines_not_containing_team_goal_data
    rawData = "       Team            P     W    L   D    F      A     Pts\n"+
              "   -------------------------------------------------------\n"
    mungedData = SoccerLeagueDataMunger.new.munge(rawData)
    assert_equal([], mungedData)
  end
  def test_parses_line_containing_team_goal_data
    rawData = "    1. Arsenal         38    26   9   3    79  -  36    87\n"
    mungedData = SoccerLeagueDataMunger.new.munge(rawData)
    assert_equal([MungedData.new("Arsenal", 36, 79)], mungedData)
  end
end
