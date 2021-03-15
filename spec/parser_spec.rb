require './lib/parser.rb'

describe Parser do
  let(:parser) { Parser.new }
  let(:url) { 'https://github.com' }
  before { parser.url = url }

  describe 'Check url from instance' do
    it 'Check that test url equals instance url' do
      expect(parser.instance_variable_get(:@url)).to eq(url)
    end
  end

  describe 'Check parse page by selector' do
    let(:selector_name) { 'title' }
    let(:title_value) { 'GitHub: Where the world builds software · GitHub' }
    let(:raw_data) { parser.get_raw_data(url) }
    let(:parsed_data) { parser.get_parsed_data(raw_data) }

    it 'Checks that raw data exist in page' do
      expect(raw_data.empty?).to_not be true
    end

    it 'Checks that parsed data exist in page' do
      expect(parsed_data.blank?).to_not be true
    end

    it 'Checks that title selector contains in page' do
      selector = parsed_data.css(selector_name)
      expect(selector.empty?).to_not be true
    end

    it 'Checks that title selector exist in page' do
      selector_value = parser.parse_page_by_selector(selector_name)
      expect(selector_value.size.positive?).to be true
    end

    it 'Checks that page parse by title selector' do
      selector_value = parser.parse_page_by_selector(selector_name)
      expect(title_value).to eq(selector_value)
    end
  end
end