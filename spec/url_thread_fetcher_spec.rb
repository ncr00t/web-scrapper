require './lib/urls_thread_fetcher.rb'
require './lib/csv_writer.rb'
require './lib/parser.rb'
require './helpers/script_helper.rb'

include ScriptHelper

describe UrlThreadFetcher do
  let(:selector_name) { 'title' }
  let(:headers) { ['URL', selector_name.capitalize] }
  let(:file_path) { generate_name_with_time('test', 'csv') }
  let(:url_list) { %w[https://google.com https://github.com] }
  let(:writer) { CSVWriter.new(file_path, headers) }
  let(:parser) { Parser.new }
  let(:url_thread_fetcher) { UrlThreadFetcher.new(url_list, writer, parser) }

  describe 'Check instance variables' do
    it 'Check that test url_list equals instance url_list' do
      instance_url_list = url_thread_fetcher.instance_variable_get(:@url_list)
      expect(instance_url_list.size).to eq(url_list.size)
      expect(instance_url_list.difference(url_list)
                              .none?).to be true
    end

    it 'Check that test parser equals instance parser' do
      expect(url_thread_fetcher.instance_variable_get(:@parser)).to eq(parser)
    end

    it 'Check that test writer equals instance writer' do
      expect(url_thread_fetcher.instance_variable_get(:@writer)).to eq(writer)
    end
  end

  describe 'Check titles from source urls' do
    let(:google_title) { 'Google' }
    let(:github_title) { 'GitHub: Where the world builds software · GitHub' }
    let(:urls_selectors) { url_thread_fetcher.fetch_data(selector_name) }

    it 'Check that fetched data is exist' do
      expect(urls_selectors.size).to eq(2)
    end

    it 'Check that fetched values equals with test titles' do
      google_url = url_list.first
      github_url = url_list.last
      expect(urls_selectors[google_url]).to eq(google_title)
      expect(urls_selectors[github_url]).to eq(github_title)
    end
  end
end