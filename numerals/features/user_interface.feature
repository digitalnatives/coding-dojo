Feature: Provide a simple form for the user so that she can use the converter

  Background:
    Given I am on the main page

  Scenario: Display a number as a word
    Given I am on the main page
     When I enter 10 into my field
      And I press submit
     Then I see it as a name in the result
      And I see the original number as well

  Scenario: Don't display anything when the user pressed submit without giving a number
    Given I am on the main page
     When I press submit
     Then I do not see any errors just the contents of the main page

  Scenario: Don't display anything when the user gave something else than a number
    Given I am on the main page
     When I enter something else than a number into my field
      And I press submit
     Then I do not see any errors just the contents of the main page
