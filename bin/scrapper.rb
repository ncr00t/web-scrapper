require './lib/parser.rb'
require './lib/console_table.rb'
require './lib/csv_writer.rb'
require './lib/urls_thread_fetcher.rb'
require './helpers/script_helper.rb'

include ScriptHelper

SYNTAX = "ruby bin/scrapper.rb urls='https://example.com, ...' [selector='SelectorName'] [file_path='result.csv']"

def run_script
  print_error(SYNTAX) if get_argument('-h') ||
                         get_argument('--help')
  selector_name = get_argument('selector') || 'title'
  file_path = get_argument('file_path') ||
              generate_name_with_time('history', 'csv')

  if get_argument('urls')
    url_list = parse_urls('urls')
  else
    print_error("Please set URLs as argument (urls='https://mail.ru, https://vk.com').")
  end

  if all_urls_valid?(url_list)
    headers = ['URL', selector_name.capitalize]
    csv_writer = CSVWriter.new(file_path, headers)
    url_fetcher = UrlThreadFetcher.new(url_list, csv_writer, Parser.new)
    urls_selectors = url_fetcher.fetch_data(selector_name)
    ConsoleTable.new(urls_selectors)
                .print_result_table(headers)
    puts "\nParsing result written in the file: #{file_path}"
  else
    print_error("URL should be start with http OR https.")
  end
end

run_script
