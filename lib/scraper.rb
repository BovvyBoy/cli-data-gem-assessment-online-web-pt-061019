require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_tool(home_url)
    Nokogiri::HTML(open(home_url))
  end


#---------AP page scrapes----------------------------------------------

  def self.scrape_ap_home_page(home_url)
    articles = []
    scrape_tool(home_url).css(".headline").drop(2).each do |storys|
      story = storys.content
      link = storys[:href]

      articles << {:title => story, :link => link}
      end
    articles
  end

  def self.scrape_ap_article_page(article_url)
    story = []
    articlepage = scrape_tool(article_url)
    story << articlepage.css(".Article").text
    story
  end

#parsed_content.css('.hub-name').first.content


#-----------------------------------------------------------------------
#--------BBC Scrapes --------------------------------------------------

  def self.scrape_bbc_home_page(home_url)
    articles = []
    homepage = Nokogiri::HTML(open(home_url))
    homepage.css(".gs-c-promo-heading").drop(1).each do |storys|
      story = storys.text
      link = storys[:href]

      articles << {:title => story, :link => link}
    end
    articles
  end

  def self.scrape_bbc_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".story-body__inner").css("p").text
    story
  end

  def self.scrape_bbc_topic_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".story-body").css("p").text
    story
  end


#--------------------------------------------------------------------------
#-----TBIJ Scrapes---------------------------------------------------------


  def self.scrape_tbij_home_page(home_url)
    articles = []
    homepage = Nokogiri::HTML(open(home_url))
    homepage.css(".tb-c-story-preview").each_with_index do |storys, i|
      i += 1
      story = storys.css("h2").text
      link = storys[:href]

      articles << {:title => story, :link => link}
    end
    articles
  end

  def self.scrape_tbij_article_page(article_url)
    story = []
    articlepage = Nokogiri::HTML(open(article_url))
    story << articlepage.css(".tb-c-story-text-block").css("p").text
    story
  end

end
