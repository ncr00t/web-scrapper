require 'httparty'
require 'nokogiri'

class Parser
  attr_accessor :url

  def parse_page_by_selector(selector_name)
    raw_data = get_raw_data(@url)
    parsed_page = get_parsed_data(raw_data)
    parsed_page.css(selector_name).text
  end

  def get_raw_data(url)
    HTTParty.get(url)
  end

  def get_parsed_data(raw_data)
    Nokogiri::HTML(raw_data.body)
  end
end