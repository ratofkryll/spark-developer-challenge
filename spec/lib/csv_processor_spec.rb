require 'csv_processor'

RSpec.describe 'csv_processor' do
  csv_processor = CsvProcessor.new
  row_hash = csv_processor.parse_file('exercise/contacts.csv').first

  # This assumes we are always using the same test CSV
  it 'reads and outputs each row of the csv' do
    expect(row_hash).to eq({
      :first_name=>"Glenda",
      :last_name=>"Rosas",
      :email=>"glendarrosas@dodgit.com",
      :phone=>"613-937-0694",
      :address_line_1=>"326 Donato Ridges",
      :city=>"Rimbey",
      :province=>"AB",
      :country_name=>"Canada",
      :postcode=>"T0C 2J0",
      :date_added=>"2015-02-24 10:54:02 UTC",
      :how_did_you_hear_about_us=>"Newspaper",
      :what_is_your_budget=>"$200-$299",
      :what_is_your_favourite_color=>"Blue"
      })
  end

  it 'filters rows with nil values for contact info' do
    row_hash_with_nil = row_hash.clone
    row_hash_with_nil[:email] = nil

    expect(csv_processor.validate_row(row_hash_with_nil)).to eql false
  end

  it 'filters rows with empty string values for contact info' do
    row_hash_with_empty = row_hash.clone
    row_hash_with_empty[:city] = ""

    expect(csv_processor.validate_row(row_hash_with_empty)).to eql false
  end

  it 'returns true when all contact info is present' do
    expect(csv_processor.validate_row(row_hash)).to eql true
  end
end
