class Progressbar
  def initialize(start, finish)
    @start = start
    @finish = finish
    @index = @start #create an variable inside the Progress
  end

  def start
    @start
  end

  def finish
    @finish
  end

  def increment # add 1 to index
    @index = @index + 1
  end

  def output
    puts "#{@index}/#{@finish}"
  end
end
