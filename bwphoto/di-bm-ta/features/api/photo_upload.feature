Feature: Photo upload

  Scenario: Upload photo with an URL
    Given I post JSON to "/api/photos.json" with:
    """
      {
        "url": "http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg",
        "camera": "Sony",
        "title": "marmot_king",
        "author": "Robert",
        "taken_at": "2012-08-01 12:45"
      }
    """
    Then I should get a response with status 200
    And I should have 1 photo(s) in the database

  Scenario: Upload photo with a file (base64)
    Given I post JSON to "/api/photos.json" with:
    """
      {
        "base64": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3AkRDwwzVKRNWAAAAB1pVFh0Q29tbWVudAAAAAAAQ3JlYXRlZCB3aXRoIEdJTVBkLmUHAAAADUlEQVQI12NgYGBgAAAABQABXvMqOgAAAABJRU5ErkJggg==",
        "filename": "valami.jpg",
        "camera": "Sony",
        "title": "marmot_king",
        "author": "Robert",
        "taken_at": "2012-08-01 12:45"
      }
    """
    Then I should get a response with status 200
    And I should have 1 photo(s) in the database

  Scenario: Upload photo with missing file parameter
    Given I post JSON to "/api/photos.json" with:
    """
      {
        "camera": "Sony",
        "title": "marmot_king",
        "author": "Robert",
        "taken_at": "2012-08-01 12:45"
      }
    """
    Then I should get a response with status 422
    And I should have no photo in the database


  Scenario: Upload photo with missing title parameter
    Given I post JSON to "/api/photos.json" with:
    """
      {
        "url": "http://farm9.staticflickr.com/8319/7992673887_a882d4e269_c.jpg",
        "camera": "Sony",
        "title": "",
        "author": "Robert",
        "taken_at": "2012-08-01 12:45"
      }
    """
    Then I should get a response with status 422
    And I should have no photo in the database
