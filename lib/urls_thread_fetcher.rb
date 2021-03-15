class UrlThreadFetcher
  attr_accessor :url_list, :writer, :parser

  def initialize(url_list, writer, parser)
    @url_list = url_list
    @writer = writer
    @parser = parser
  end

  def fetch_data(selector_name)
    mutex = Mutex.new
    threads = []
    urls_selectors = {}

    @url_list.each do |url|
      threads << Thread.new(url) do |url|
        @parser.url = url
        selector_value = @parser.parse_page_by_selector(selector_name)
        urls_selectors[url] = selector_value
        mutex.synchronize { @writer.write(urls_selectors) }
      end
    end
    threads.each(&:join)
    urls_selectors
  end
end