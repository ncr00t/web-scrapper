require './lib/console_table.rb'
require './helpers/script_helper.rb'

include ScriptHelper

describe ConsoleTable do
  let(:urls_selectors) {
    {
      'https://google.com' => 'google title',
      'https://github.com' => 'github title'
    }
  }
  let(:console_table) { ConsoleTable.new(urls_selectors) }

  describe 'Check instance variables' do
    it 'Check that test total_urls equals instance total_urls' do
      instance_total_urls = console_table.instance_variable_get(:@total_urls)
      test_total_urls = urls_selectors.size
      expect(instance_total_urls).to eq(test_total_urls)
      expect(instance_total_urls).to eq(2)
    end

    it 'Check that test urls_selectors equals instance urls_selectors' do
      instance_urls_selectors = console_table.instance_variable_get(:@urls_selectors).to_a
      test_urls_selectors = urls_selectors.to_a
      expect(instance_urls_selectors.size).to eq(test_urls_selectors.size)
      expect(instance_urls_selectors.difference(test_urls_selectors)
                                    .none?).to be true
    end
  end
end