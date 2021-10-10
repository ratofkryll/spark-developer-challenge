require 'csv'

class CsvProcessor
  # Open a CSV and return a collection we can work with
  def parse_file(csv)
    data = []
    errors = []
    invalid_rows = 0

    CSV.foreach(csv, headers: true, header_converters: :symbol).with_index(1) do |row, i|
      row_hash = row.to_h

      if validate_row(row_hash)
      # This way will eat a lot of memory for large files. TODO: Refactor for large file handling
        data << row_hash
      else
        invalid_rows += 1
        errors << "Row #{i} is missing contact info.\n"
      end
    end
    valid_rows = filter_duplicate_rows(data)
    print_report(valid_rows.count, count_duplicate_rows(data), invalid_rows, errors)
    valid_rows
  end

  ## Validation

  # Check if the row is missing contact information
  def validate_row(row_hash)
    return unless row_hash

    # Add required keys to a variable, mainly for readability
    required_keys = [:first_name, :last_name, :email, :phone, :address_line_1, :city, :province, :country_name, :postcode, :date_added]

    # Returns false if any of the required keys are nil or an empty string. In Rails, you could use .blank? to check for both nil and an empty string
    required_keys.all? { |x| !row_hash[x].nil? && !row_hash[x].empty? }
  end

  # Return a count of duplicate rows
  def count_duplicate_rows(csv_data)
    # Grouping on first name, last name, email & phone - two different people with the same name shouldn't be counted as one, and if a person has moved they won't be counted as two (people are likely to keep the same email and phone number)
    grouped_data = csv_data.group_by { |row| [row[:first_name], row[:last_name], row[:email], row[:phone]] }.transform_values(&:count)

    grouped_data.count { |k,v| v > 1 }
  end

  # Return a new array with duplicate contacts removed
  def filter_duplicate_rows(csv_data)
    # Sort the entire array on date and reverse to sort descending
    sorted_data = csv_data.sort_by { |row| row[:date_added]}.reverse!

    # Select the first unique contact that matches all of the required values.
    sorted_data.uniq { |row| [row[:first_name], row[:last_name], row[:email], row[:phone]] }
  end

  ## Data Manipulation



  ## Reporting

  # Prints a report of the contacts to the console
  def print_report(total_contacts, duplicate_contacts, invalid_contacts, errors)
    # Contact summary
    print "Total Contacts: #{total_contacts}\nDuplicate Contacts: #{duplicate_contacts}\nInvalid Contacts: #{invalid_contacts}\n"

    # Validation errors
    errors.each do |error|
      print error
    end
  end
end
