class Topic
  attr_accessor :name, :channel
  @@all = []

  def initialize(name, channel = "Unsorted")
    @name = name
    @channel = channel
    @@all << self
  end

  def self.all
    @@all
  end

end
