module ScriptHelper
  def print_error(message)
    puts message
    exit(0)
  end

  def generate_name_with_time(name, extension)
    date_now = Time.now.strftime("%Y%m%d_%H%M%S")
    "#{name}_#{date_now}.#{extension}"
  end

  def parse_argument(arg_name)
    applicable = ARGV.find_all { |arg| arg[0..(arg_name.size - 1)] == arg_name }
    if applicable.one?
      applicable[0][(arg_name.size)..(applicable[0].size)]
    elsif applicable.empty?
      nil
    else
      raise "Found #{applicable.size} args matching #{arg_name}: #{applicable.join(', ')}"
    end
  end

  def get_argument(arg_name)
    parse_argument(arg_name + '=') || parse_argument(arg_name)
  end

  def all_urls_valid?(url_list)
    invalid_urls = url_list.select { |url| url unless url.start_with?('http') }
    invalid_urls.empty?
  end

  def parse_urls(arg_name)
    get_argument(arg_name).split(/[\s,]+/).uniq
  end
end