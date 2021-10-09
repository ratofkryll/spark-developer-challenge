require 'csv_processor'

RSpec.describe 'csv_processor' do
  csv_processor = CsvProcessor.new

  it 'reads and outputs each row of the csv' do
    expect(csv_processor.parse_file('exercise/contacts.csv').first).to eq({
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
end
