Feature: View photo
  Background:
    Given the following photos exist:
      | id | camera | title   | author | taken_at         | status     |
      | 1  | Nikon  | Singing | Robert | 2012-08-01 12:00 | processed  |
      | 2  | Canon  | Jumping | Zdlena | 2012-08-01 12:00 | queued     |

  Scenario: View processed photo
    When I visit "/api/photos/1.json"
    Then the JSON at "id" should be 1
    And the JSON at "url" should not be ""

  Scenario: View unprocessed photo
    When I visit "/api/photos/2.json"
    #Then I should get a response with status 450
    And the JSON at "error" should be "photo isn't available yet"

  Scenario: Request not existing photo
    When I visit "/api/photos/3.json"
    #Then I should get a response with status 404
    And the JSON at "error" should be "photo isn't found"