@javascript
Feature: Translate
  Scenario: Translate
    Given I am on the translation page
    When I translate "105"
    Then I should get "one hundred five" as result