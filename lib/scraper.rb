require 'open-uri'
require 'pry'

class Scraper
#---------Home page scrapes

  @@bbc_links = []
  @@ap_links = []
  @@tbij_links = []
  @@bbc_top5 = []
  @@ap_top5 =[]
  @@tbij_top5

  def self.bbc_links
    @@bbc_links
  end

  def self.ap_links
    @@ap_links
  end

  def self.tbij_links
    @@tbij_links
  end

  def self.bbc_top5
    @@bbc_top5
  end

  def self.ap_top5
    @@ap_top5
  end

  def self.tbij_top5
    @@tbij_top5
  end

  def self.scrape_ap_home_page(home_url)
    @@ap_links = []
    @@ap_top5= []
    homepage = Nokogiri::HTML(open(home_url))
      homepage.css(".headline").drop(2).each do |storys|
        story = storys.content
        link = storys[:href]
        @@ap_top5 << story
        @@ap_links << link
      end
    @@ap_top5[0..4].each_with_index {|heading, i| puts "#{i += 1}  " + heading}
  end

  def self.scrape_bbc_home_page(home_url)
    @@bbc_links = []
    @@bbc_top5 = []
    homepage = Nokogiri::HTML(open(home_url))
    homepage.css(".gs-c-promo-heading").drop(1).each do |storys|
      story = storys.text
      link = storys[:href]
      @@bbc_top5 << story
      @@bbc_links << link
    end
    @@bbc_top5[0..4].each_with_index {|heading, i| puts "#{i += 1}  " + heading}
  end

  def self.scrape_tbij_home_page(home_url)
    @@tbij_links = []
    @@tbij = []
    homepage = Nokogiri::HTML(open(home_url))
    homepage.css(".tb-c-story-preview").each_with_index do |storys, i|
      i += 1
      story = storys.css("h2").text
      link = storys[:href]
      @@tbij_top5 << "#{i}. " + story
      @@tbij_links << link
    end
    puts top_stories[0..4]
  end


#---------Article page scrapes
  def self.scrape_ap_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".Article").text
    puts story
  end

  def self.scrape_bbc_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".story-body__inner").css("p").text
    puts story
  end

  def self.scrape_tbij_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".tb-c-story-text-block").css("p").text
    puts story
  end
#--------Topic page scrapes

  def self.scrape_bbc_topic_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".story-body").css("p").text
    puts story
  end


end
