## Instructions

* Use Ruby 3.0.1
* cd into `spark-developer-challenge`
* `bundle install`
* `bundle exec rspec` to run with tests

## Tech Specs & Gems

* Ruby 3.0.1
* Rspec 3.10.0

## My Coding Steps

1. Basic CSV handling
  * Import file
  * Output contents to command line
2. Validate CSV rows
  * Return errors for invalid rows
  * Get a count of duplicate rows
  * Sort contacts and filter out duplicate rows
3. Create a contact summary - tallies of valid, invalid, and duplicate contacts
4. Map questions to the contacts who answered them
5. Refactor error reporting to make sure it accounts for both duplicate and invalid contacts
  * Keep the most recently added version of the contact

## Assumptions

* All contact info fields and date_added are required for a contact to be valid
* People are unlikely to change their email address or phone number if they move

## General Notes

* For the purpose of this exercise, I created a single class with methods to handle the various functionality that was specified. In the case that the scope was likely to change or get larger, I'd split it into multiple classes - most likely for CSV handling, error handling, and reporting, or something along those lines.

* Along the same lines, the CSV processor is run from the csv_processor file. I felt it would be best to keep it simple and avoid overcomplicating the assignment.

* Please let me know if you have any questions or feedback, or if you'd like me to make any revisions.
