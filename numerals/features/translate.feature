Feature: Translate
  @javascript
  Scenario: Translate
    Given I am on the translation page
    When I translate "105"
    Then I should get "one hundred five" as result

  Scenario: Translate via json api
    Given The api receives a translation request with number "105"
    Then The response should contain "one hundred five" as result