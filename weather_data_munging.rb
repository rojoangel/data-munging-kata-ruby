require "./exceptions.rb"

class WeatherDataMunger
  def munge data
    raise Exceptions::EmptyData
  end
end
