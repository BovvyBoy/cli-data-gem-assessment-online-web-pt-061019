class Channel
  attr_accessor :name, :article, :topic
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  

end
