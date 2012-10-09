Feature: User API
  Background:
    Given the following photos exist:
      | id | camera | title   | author | taken_at         |
      | 1  | Nikon  | Singing | Robert | 2012-08-01 12:00 |
      | 2  | Canon  | Jumping | Zdlena | 2012-08-01 12:00 |
      | 3  | Fuji   | Dancing | Zdlena | 2012-08-01 12:00 |
      | 4  | Konica | Running | Robert | 2012-08-01 12:00 |
      | 5  | Sony   | Sitting | Robert | 2012-08-01 12:00 |

  Scenario: List
    When I visit "/api/photos.json"
    Then the JSON response should have 3 photos
    And the JSON response should have the following:
      | 0/id | 3 |
      | 1/id | 2 |
      | 2/id | 1 |
