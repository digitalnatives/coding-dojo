Feature: User
  Background:
    Given I have a user with id 1 and name Tamas Tompa

  Scenario: Get the user
     When I get the user
     Then I the username should be Tamas Tompa
      And I the id should be 1

  Scenario: Update the user
     When I set the username to Gusztav Szikszai
     Then I shouldnt get an error

  Scenario: Update the user and fail
     When I set the username to ''
     Then I should get an error

  Scenario: Get the comments of the user
    Given I have a comment for the user with id 1 and message Hello World
     When I get the comment
     Then The comment id should be 1
      And The comment message should be Hello World
      And There should be a timestamp

  Scenario: New comment
     When I add a new comment with message Bye Bye World!
     Then I shouldnt get an error

  Scenario: New comment and fail
     When I add a new comment with message ''
     Then I should get an error

      
