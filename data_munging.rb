class MungedData
  include Comparable

  attr_reader :label, :low, :high

  def initialize(label, low, high)
    @label = label
    @low   = low
    @high  = high
  end
  def difference
    (@high - @low).abs
  end

  def <=>(other)
    if self.label < other.label
      -1
    elsif self.label > other.label
      1
    elsif self.low < other.low
      -1
    elsif self.low > other.low
      1
    elsif self.high < other.high
      -1
    elsif self.high > other.high
      1
    else
      0
    end
  end
end

class SmallestDifferenceCalculator
  def process data
    if data.empty?
      raise Exceptions::EmptyData
    else
      data.inject{|smallestDifferenceData, data| if data.difference < smallestDifferenceData.difference then data else smallestDifferenceData end}.label
    end
  end
end
