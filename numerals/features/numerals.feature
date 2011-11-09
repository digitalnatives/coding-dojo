Feature: English numerals

Scenario: As a visitor I would like load the page
  Given I am on the home page
  Then I should see the number field
   And I should see the submit button

Scenario: As a visitor I would like submit a number
  Given I am on the home page
  When I fill in "number" with "42"
   And I press "commit"
  Then I should see "42"

