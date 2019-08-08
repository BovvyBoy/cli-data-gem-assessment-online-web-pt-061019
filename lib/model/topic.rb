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

  def articles
    Articles.all.select {|article|article.topic == self}
  end

  def channels
    articles.map{|article|article.channel == self}
  end

end
