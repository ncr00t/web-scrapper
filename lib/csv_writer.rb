class CSVWriter
  attr_accessor :file_path, :headers

  def initialize(file_path, headers)
    @file_path = file_path
    @headers = headers
  end

  def write(hash)
    csv_options = { headers: :first_row, col_sep: ',' }
    CSV.open(file_path, 'wb', csv_options) do |csv|
      csv << @headers
      hash.each { |url, selector| csv << [url, selector] }
    end
  end
end