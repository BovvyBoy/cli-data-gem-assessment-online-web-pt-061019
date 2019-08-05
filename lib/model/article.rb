class Article
  attr_accessor :title, :content, :channel, :topic, :link
  @@all = []

  def initialize(title, content, topic = "Not Stated", channel = "Unsorted", link = "Unknown")
    @title = title
    @content = content
    @channel = channel
    @topic = topic
    @link = link
    @@all << self
  end

  def self.all
    @@all
  end

  def new_from_scrape(title, content, channel, topic, link)
      Article.new(title, content, channel, topic, link)
  end



end
