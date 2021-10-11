require 'csv'

class CsvProcessor
  # Open a CSV and return a collection we can work with
  def parse_file(csv)
    csv_data = []
    invalid_row_count = 0

    CSV.foreach(csv, headers: true, header_converters: :symbol).with_index(1) do |row, i|
      row_hash = row.to_h
      row_hash[:row_number] = i
      row_hash[:validation_errors] = row_validation_errors(row_hash)
      invalid_row_count += 1 unless row_hash[:validation_errors].empty?
      csv_data << row_hash
    end

    duplicate_rows = mark_duplicate_rows(csv_data)
    rows = csv_data.group_by{ |row| row[:validation_errors].empty? }
    valid_data = rows[true]
    invalid_rows = rows[false]

    list_valid_contacts(valid_data)
    print_report(valid_data.count, duplicate_rows, invalid_row_count)
    map_answers(valid_data, question: :how_did_you_hear_about_us)
    map_answers(valid_data, question: :what_is_your_budget)
    map_answers(valid_data, question: :what_is_your_favourite_color)
    print_errors(invalid_rows)
  end

  ## Validation

  # Check if the row is missing contact information
  def validate_row(row_hash)
    row_validation_errors(row_hash).empty?
  end

  def row_validation_errors(row_hash)
    validation_errors = []
    # Add required keys to a variable, mainly for readability
    required_keys = [:first_name, :last_name, :email, :phone, :address_line_1, :city, :province, :country_name, :postcode, :date_added]
    required_keys.each do |key|
      validation_errors.append(key) if row_hash[key]&.empty? != false
    end
    validation_errors
  end

  # Return a count of duplicate rows
  def mark_duplicate_rows(csv_data)
    # Grouping on first name, last name, email & phone - two different people with the same name shouldn't be counted as one, and if a person has moved they won't be counted as two (people are likely to keep the same email and phone number)
    grouped_data = csv_data.group_by { |row| [row[:first_name], row[:last_name], row[:email], row[:phone]] }
    grouped_data.each do |k,rows|
      rows.sort_by! { |row| row[:date_added]}.reverse!
      rows[1..].each do |row|
        row[:validation_errors].append(:duplicate)
      end
    end

    grouped_data.transform_values(&:count).count { |k,v| v > 1 }
  end

  ## Reporting

  # Prints a list of contacts and their answers
  def list_valid_contacts(csv_data)
    csv_data.each do |contact|
      # Contact information
      print "#{contact[:first_name]} #{contact[:last_name]}\n#{contact[:email]} | #{contact[:phone]}\n#{contact[:address_line_1]}\n#{contact[:city]}, #{contact[:province]} #{contact[:postcode]}\n#{contact[:country_name]}\n"
      # Answers
      print "How did you hear about us? #{contact[:how_did_you_hear_about_us]}\n"
      print "What is your budget? #{contact[:what_is_your_budget]}\n"
      print "What is your favourite colour? #{contact[:what_is_your_favourite_color]}\n\n"
    end
  end

  # Prints a report of the contacts to the console
  def print_report(total_contacts, duplicate_contacts, invalid_contacts)
    # Contact summary
    print "Summary:\n"
    print "Total Valid Contacts: #{total_contacts}\nDuplicate Contacts: #{duplicate_contacts}\nInvalid Contacts: #{invalid_contacts}\n\n"
  end

  # Prints a tally of survey answers
  def map_answers(csv_data, question:)
    print "Answered #{question.to_s.gsub('_', ' ')}?\n"
    print csv_data.group_by{ |row| row[question]&.empty? }[false]&.map{|x| [x.slice(:first_name, :last_name).values.join(' '), x[question]].join(': ') }&.join("\n")
    print "\n\n"
  end

  def print_errors(rows)
    print "Errors:\n"
    rows.each do |row|
      print "Row #{row[:row_number]} rejected: #{row[:validation_errors].join(", ")}\n"

    end
    print "\n"
  end
end

csv_processor = CsvProcessor.new
csv_processor.parse_file('exercise/contacts.csv')
