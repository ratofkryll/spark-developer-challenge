require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

class CsvProcessor
  def parse_file(csv)
    data = []

    CSV.foreach(csv, headers: true, header_converters: :symbol) do |row|
      data << row.to_h
    end

    data
  end
end
