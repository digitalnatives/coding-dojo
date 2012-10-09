Feature: View photo
  Background:
    Given the following photos exist:
      | id | camera | title   | author | taken_at         | status     |
      | 1  | Nikon  | Singing | Robert | 2012-08-01 12:00 | processed  |
      | 2  | Canon  | Jumping | Zdlena | 2012-08-01 12:00 | processing |

  Scenario: View processed photo
    When I visit "/api/photos/1.json"
    Then the JSON at "id" should be "1"
    And the JSON at "url" should not be ""

  Scenario: View unprocessed photo
    When I visit "/api/photo/2.json"
    Then I should get a response with status 204
    And the JSON at "error" should be "photo isn't available yet"