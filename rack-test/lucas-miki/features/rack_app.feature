Feature: We are on a coding dojo

  Scenario: I want see a user's details
    Given I have a user
    When I request it's details
    Then I get back a user's details
    
  Scenario: I want to update a user's attributes without errors
    Given I have a user
    When I update it's details without errors
    Then I get back a success message

  Scenario: I want to update a user's attributes with errors
    Given I have a user
    When I update it's details with errors
    Then I get back an error message
  
  Scenario: I want to retreive a user's comments
    Given I have a user
    When I request it's comments
    Then I get back a user's comments

  Scenario: I want to add a new user comment without error
    Given I have a user
    When I add a new comment to him without error
    Then I get back a success message

  Scenario: I want to add a new user comment with error
    Given I have a user
    When I add a new comment to him with error
    Then I get back an error message
