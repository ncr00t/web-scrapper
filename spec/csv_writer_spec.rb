require './lib/csv_writer.rb'
require './helpers/script_helper.rb'

include ScriptHelper

describe CSVWriter do
  let(:selector_name) { 'title' }
  let(:headers) { ['URL', selector_name.capitalize] }
  let(:file_path) { generate_name_with_time('test', 'csv') }
  let(:csv_writer) { CSVWriter.new(file_path, headers) }

  describe 'Check instance variables' do
    it 'Check that test file_path equals instance file_path' do
      instance_file_path = csv_writer.instance_variable_get(:@file_path)
      expect(instance_file_path).to eq(file_path)
    end

    it 'Check that test headers equals instance headers' do
      instance_headers = csv_writer.instance_variable_get(:@headers)
      expect(instance_headers.size).to eq(headers.size)
      expect(instance_headers.difference(headers)
                             .none?).to be true
    end
  end

  describe 'Check writing to file' do
    let(:urls_selectors) {
      {
        'https://google.com' => 'google title',
        'https://github.com' => 'github title'
      }
    }

    it 'Check that data was written to file' do
      csv_writer.write(urls_selectors)
      csv_table = CSV.read(file_path, headers: true)
      count_rows_without_headers = csv_table.count
      expect(count_rows_without_headers).to eq(2)
      expect(csv_table.headers
                      .difference(headers)
                      .none?).to be true
    end
  end
end