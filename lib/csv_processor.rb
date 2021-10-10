require 'csv'

class CsvProcessor
  # Open a CSV and return a collection we can work with
  def parse_file(csv)
    data = []

    CSV.foreach(csv, headers: true, header_converters: :symbol).with_index(1) do |row, i|
      row_hash = row.to_h

      if validate_row(row_hash)
      # This way will eat a lot of memory for large files. TODO: Refactor for large file handling
        data << row_hash
      else
        puts "Row #{i} is missing information."
      end
    end

    data
  end

  # Check if the row is missing contact information.
  def validate_row(row_hash)
    return unless row_hash

    required_keys = [:first_name, :last_name, :email, :phone, :address_line_1, :city, :province, :country_name, :postcode, :date_added]

    # Returns false if any of the required keys are nil or an empty string. In Rails, you could use .blank? to check for both nil and an empty string
    required_keys.all? { |x| !row_hash[x].nil? && !row_hash[x].empty? }
  end
end
