require 'terminal-table'

class ConsoleTable
  attr_accessor :urls_selectors, :total_urls

  def initialize(urls_selectors)
    @urls_selectors = urls_selectors
    @total_urls = urls_selectors.keys.count
  end

  def print_result_table(headers)
    puts build_result_table(headers)
  end

  private

  def build_result_table(headers)
    Terminal::Table.new(
      rows: @urls_selectors,
      headings: headers,
      style: { border_i: '#' }
    )
  end
end