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
      ap_topstories
      article_selection
    when input = "2"
      @@base_path = "https://www.bbc.co.uk/news"
      bbc_topstories
      article_selection
    when input = "3"
      @@base_path = "https://www.thebureauinvestigates.com/stories/"
      tbij_topstories
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

  def ap_topstories
    Scraper.scrape_ap_home_page(@@base_path)
  end

  def bbc_topstories
    Scraper.scrape_bbc_home_page(@@base_path)
  end

  def tbij_topstories
    Scraper.scrape_tbij_home_page(@@base_path)
  end

  def ap_topic_search(extention)
    Scraper.scrape_ap_home_page("https://www.apnews.com/" + extention)
  end

  def bbc_topic_search(extention)
    Scraper.scrape_bbc_home_page("https://www.bbc.co.uk/" + extention)
  end

  def article_selection
    input = gets.chomp()
    case input
    when "1"
      if @@base_path == "https://www.apnews.com/"
        Scraper.scrape_ap_article_page(@@base_path + Scraper.ap_links[2])
      elsif @@base_path == "https://www.bbc.co.uk/news"
        Scraper.scrape_bbc_article_page("https://www.bbc.co.uk" + Scraper.bbc_links[0])
      elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
        Scraper.scrape_tbij_article_page(Scraper.tbij_links[0])
      end
    when "2"
      if @@base_path == "https://www.apnews.com/"
        Scraper.scrape_ap_article_page(@@base_path + Scraper.ap_links[3])
      elsif @@base_path == "https://www.bbc.co.uk/news"
        Scraper.scrape_bbc_article_page("https://www.bbc.co.uk" + Scraper.bbc_links[1])
      elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
        Scraper.scrape_tbij_article_page(Scraper.tbij_links[1])
      end
    when "3"
      if @@base_path == "https://www.apnews.com/"
        Scraper.scrape_ap_article_page(@@base_path + Scraper.ap_links[4])
      elsif @@base_path == "https://www.bbc.co.uk/news"
        Scraper.scrape_bbc_article_page("https://www.bbc.co.uk" + Scraper.bbc_links[2])
      elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
        Scraper.scrape_tbij_article_page(Scraper.tbij_links[2])
      end
    when "4"
      if @@base_path == "https://www.apnews.com/"
        Scraper.scrape_ap_article_page(@@base_path + Scraper.ap_links[5])
      elsif @@base_path == "https://www.bbc.co.uk/news"
        Scraper.scrape_bbc_article_page("https://www.bbc.co.uk" + Scraper.bbc_links[3])
      elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
        Scraper.scrape_tbij_article_page(Scraper.tbij_links[3])
      end
    when "5"
      if @@base_path == "https://www.apnews.com/"
        Scraper.scrape_ap_article_page(@@base_path + Scraper.ap_links[6])
      elsif @@base_path == "https://www.bbc.co.uk/news"
        Scraper.scrape_bbc_article_page("https://www.bbc.co.uk" + Scraper.bbc_links[4])
      elsif @@base_path == "https://www.thebureauinvestigates.com/stories/"
        Scraper.scrape_tbij_article_page(Scraper.tbij_links[4])
      end
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
