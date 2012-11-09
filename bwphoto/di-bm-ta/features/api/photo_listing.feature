Feature: User API
  Background:
    Given the following photos exist:
      | id | camera | title   | author | taken_at         | status    |
      | 1  | Nikon  | Singing | Robert | 2012-08-01 12:00 | queued    |
      | 2  | Canon  | Jumping | Zdlena | 2012-08-01 12:00 | processed |
      | 3  | Fuji   | Dancing | Zdlena | 2012-08-01 12:00 | queued    |
      | 4  | Konica | Running | Robert | 2012-08-01 12:00 | processed |
      | 5  | Sony   | Sitting | Robert | 2012-08-01 12:00 | processed |

  Scenario: List
    When I visit "/api/photos.json"
    Then the JSON response should have 3 photos
    And the JSON response should have the following:
      | 0/id | 2 |
      | 1/id | 4 |
      | 2/id | 5 |
