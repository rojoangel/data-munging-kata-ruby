require "./soccer_league_data_munging.rb"
require "test/unit"

class TestSmallestGoalDifferenceTeamCalculator < Test::Unit::TestCase
  def test_returns_error_for_empty_data
    assert_raise Exceptions::EmptyData do
      emptyData = []
      SmallestGoalDifferenceTeamCalculator.new.process(emptyData)
    end
  end
end
