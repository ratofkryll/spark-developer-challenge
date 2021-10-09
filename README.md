Welcome to the Spark software developer programming challenge.

This exercise requires you to write some Ruby code to import a CSV file of
contacts and report information on these records.

There is no time limit for completing the exercise. We would expect it to take a
few hours, but we understand that everyone works at their own pace and so there
is no strict limit.

You should initialize a new Git repository inside the exercise folder. As you
work on your solution, you should make commits to the repository along the way,
just as you would on a real project. This helps us understand your progress and
identify how you came to the solutions you did.

When you are ready to submit your code, just zip up the entire directory
(including .git/) and send it via email to ryan@spark.re.

Have fun and feel free to get in touch if you have any questions.

## Description ##

You have been provided a CSV containing a list of leads for a sales center.
Each row includes key contact information and may or may not include responses
to questions the center has asked. Some lead entries are unique and complete,
others were not entirely filled out, and others were entered twice, sometimes
with new answers.

Build a program in Ruby that can:

1. Import the contacts CSV (included). This can be in-memory, you do not need
   to create a database.
2. List only the valid contact records (not duplicate or incomplete), with each
   contact appearing only once along with the answers they have most recently
   added (if they have any answers at all).
3. Report
  - total contacts
  - duplicate contacts
  - incomplete contacts (rows for which there is no value for one or more
    headers, excluding Q&A columns)
3. Map the questions in a way that each question can be associated with the
   contacts who have answered it.
4. Return each invalid record with an error message stating why it was rejected.

Note: The program simply outputs the results to the command line (stdout)

## What we're looking for ##

Your submission will be reviewed and marked by one of our senior developers
with a focus on the following areas:

1. Separation of concerns
2. Tests (we do not expect 100% coverage)
3. Correct and straightforward instructions for running the program
4. Accurate output
5. Attention to detail
6. Consistent, idiomatic and easily maintainable Object Oriented code

You may use whichever libraries and tools are you comfortable with.
