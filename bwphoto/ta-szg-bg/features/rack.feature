Feature: API
  Background:
      Given there is 5 pictures in the database
      And I navigate to the list page

  Scenario: list view
      Then I should see 5 pictures
      And I should see upload form

  Scenario: picture view
      When I click on the first picture
      Then I should see a big picture
      And I should see metadata

  Scenario: upload picture error
      When I click submit
      Then I should see an error

  Scenario: upload picture Base64
      When I fill title with Title
       And I select a file
       And I click submit
      Then I should see a success

  Scenario: upload picture URL
      When I fill title with Title
       And I fill url with http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg
       And I click submit
      Then I should see a success

  Scenario: upload picture URL and see result
      When I fill title with Title
       And I fill url with http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg
       And I click submit
       And I wait for faye event
      Then I see the uploaded picture in the list
