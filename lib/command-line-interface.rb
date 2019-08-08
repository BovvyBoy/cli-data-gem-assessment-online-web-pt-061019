require_relative 'environment.rb'

class CommandLineInterface
  @@base_path = ""

  def run
    welcome
    input
  end

  def welcome
    puts "Welcome to News Top 3"
    puts "Please Choose a Number to Proceed:"
    puts "1.     Choose a Channel"
    puts "2.     Browse by Topic"
    puts "3.     Top Stories"
  end

  def input
    input = gets.chomp()
    case input
    when "1"
      list_channels
      channel_selection
    when "2"
      list_topics
      topic_selection
      topic_article_selection
    when "3"
      latest_top
      topic_article_selection
    else
      puts "Unknown Input Please Try Again"
      input
    end
  end

  def list_channels
    puts "1.     AP - The Associated Press"
    puts "2.     BBC - Britist Broadcast Company"
    puts "3.     TBIJ - The Bureau of Investigative Journalism"
  end

  def list_topics
    puts "1.     Sports"
    puts "2.     Entertainment"
    puts "3.     International"
    puts "4.     Technology"
    puts "5.     Business"
  end

  def channel_selection
    input = gets.chomp()
    case input
    when input = "1"
      @@base_path = "https://www.apnews.com/"
      list_topstories
      article_selection
    when input = "2"
      @@base_path = "https://www.bbc.co.uk/news"
      bbc_list_topstories
      article_selection
    when input = "3"
      @@base_path = "https://www.thebureauinvestigates.com/stories/"
      tbij_list_topstories
      article_selection
    else
      puts "Unknown Entry Please Try Again:"
      channel_selection
    end
  end

  def topic_selection
    input = gets.chomp()
    case input
    when input = "1"
      puts "TOP STORIES FROM BBC:"
      bbc_topic_search("sport")
      puts "Type bbc(*) * - the number story: "
      puts ""
      puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
      ap_topic_search("apf-sports")
      puts "Type ap(*) * - the number story: "
    when input = "2"
      puts "TOP STORIES FROM BBC:"
      bbc_topic_search("news/entertainment_and_arts")
      puts "Type bbc(*) * - the number story: "
      puts ""
      puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
      ap_topic_search("apf-entertainment")
      puts "Type ap(*) * - the number story: "
    when input = "3"
      puts "TOP STORIES FROM BBC:"
      bbc_topic_search("news/world")
      puts "Type bbc(*) * - the number story: "
      puts ""
      puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
      ap_topic_search("apf-intlnews")
      puts "Type ap(*) * - the number story: "
    when input = "4"
      puts "TOP STORIES FROM BBC:"
      bbc_topic_search("news/technology")
      puts "Type bbc(*) * - the number story: "
      puts ""
      puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
      ap_topic_search("apf-technology")
      puts "Type ap(*) * - the number story: "
    when input = "5"
      puts "TOP STORIES FROM BBC:"
      bbc_topic_search("news/business")
      puts "Type bbc(*) * - the number story: "
      puts ""
      puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
      ap_topic_search("apf-business")
      puts "Type ap(*) * - the number story: "
    else
      puts "Unknown Input Please Try again!"
      topic_selection
    end
  end
#----------------------AP------------------------------------------------
  def make_ap_topstories
    topstories = Scraper.scrape_ap_home_page("https://www.apnews.com/")
    Article.new_from_ap_scrape(topstories[0..4])
  end

  def list_topstories
    make_ap_topstories.each_with_index do |story, i|
      puts "#{i += 1}.  #{story[:title]}"
    end
  end

  def ap_topic_search(extention)
    topstories = Scraper.scrape_ap_home_page("https://www.apnews.com/" + extention)
    Article.new_from_ap_topic_scrape(topstories[0..4])
  end

  def bbc_topic_topstories
    ap_topic_search.each_with_index do |story, i|
      puts "#{i += 1}.  #{story[:title]}"
    end
  end
#---------------------------------------------------------------------------
#--------------------------------BBC----------------------------------------
  def make_bbc_topstories
    topstories = Scraper.scrape_bbc_home_page("https://www.bbc.co.uk/news")
    Article.new_from_bbc_scrape(topstories[0..4])
  end

  def bbc_list_topstories
    make_bbc_topstories.each_with_index do |story, i|
      puts "#{i += 1}.  #{story[:title]}"
    end
  end

  def bbc_topic_search(extention)
    topstories = Scraper.scrape_bbc_home_page("https://www.bbc.co.uk/" + extention)
    Article.new_from_bbc_topic_scrape(topstories[0..4])
  end

  def bbc_topic_topstories
    bbc_topic_search.each_with_index do |story, i|
      puts "#{i += 1}.  #{story[:title]}"
    end
  end
  #---------------------------------------------------------------------------
  #-------------------------------TBIJ----------------------------------------
  def make_tbij_topstories
    topstories = Scraper.scrape_tbij_home_page("https://www.thebureauinvestigates.com/stories/")
    Article.new_from_tbij_scrape(topstories[0..4])
  end

  def tbij_list_topstories
    make_tbij_topstories.each_with_index do |story, i|
      puts "#{i += 1}.  #{story[:title]}"
    end
  end
#---------------------------------------------------------------------------



  def latest_top
    puts "TOP STORIES FROM BBC:"
    bbc_topstories
    puts "Type bbc(*) * - the number story: "
    puts ""
    puts "TOP STORIES FROM THE ASSOCIATED PRESS:"
    ap_topstories
    puts "Type ap(*) * - the number story: "
  end

  def navigate
    puts ""
    puts "< = back to stories."
    puts "<< = back to main menu"
  end

  def nav_input
    input = gets.chomp()
    case input
    when "<"
      list_topstories
      article_selection
    when "<<"
      run
    else
      puts "Unknown Please Try Again!!"
    end
  end

  def article_selection
    input = gets.chomp()
    case input
    when "1"
      puts Article.all[0].content
      navigate
      nav_input
    when "2"
      puts Article.all[1].content
      navigate
      nav_input
    when "3"
      puts Article.all[2].content
      navigate
      nav_input
    when "4"
      puts Article.all[3].content
      navigate
      nav_input
    when "5"
      puts Article.all[4].content
      navigate
      nav_input
    else
      puts "Unknown Input Please Try Again!"
      article_selection
    end
  end

  def topic_article_selection
    input = gets.chomp()
    case input
    when input = "bbc1"
      Scraper.scrape_bbc_topic_article_page("https://www.bbc.co.uk/" + Scraper.bbc_links[0])
    when input = "bbc2"
      Scraper.scrape_bbc_topic_article_page("https://www.bbc.co.uk/" + Scraper.bbc_links[1])
    when input = "bbc3"
      Scraper.scrape_bbc_topic_article_page("https://www.bbc.co.uk/" + Scraper.bbc_links[2])
    when input = "bbc4"
      Scraper.scrape_bbc_topic_article_page("https://www.bbc.co.uk/" + Scraper.bbc_links[3])
    when input = "bbc5"
      Scraper.scrape_bbc_topic_article_page("https://www.bbc.co.uk/" + Scraper.bbc_links[4])
    when input = "ap1"
      Scraper.scrape_ap_article_page("https://www.apnews.com/" + Scraper.ap_links[0])
    when input = "ap2"
      Scraper.scrape_ap_article_page("https://www.apnews.com/" + Scraper.ap_links[1])
    when input = "ap3"
      Scraper.scrape_ap_article_page("https://www.apnews.com/" + Scraper.ap_links[2])
    when input = "ap4"
      Scraper.scrape_ap_article_page("https://www.apnews.com/" + Scraper.ap_links[3])
    when input = "ap5"
      Scraper.scrape_ap_article_page("https://www.apnews.com/" + Scraper.ap_links[4])
    else
      puts "Sorry Invalid Entry Please Check And Try Again:"
      topic_article_selection
    end
  end


end
