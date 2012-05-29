Feature: Router

	
	Scenario: Redirect to users
		Given I go to the "main" page and the request type is "GET"
		Then I should be redirected to the "users" page

	Scenario: Show a user
		Given I go to the "user #5" page and the request type is "GET"
		Then I should see the "user #5"'s JSON object

	Scenario: Update a user
		Given I go to the "user #5" page and the request type is "POST"
		And the POST data is '{id: 5, name: "user"}'
		Then I should see "success" response status

	Scenario: Show comments of a user
		Given I go to the "comments" page of "user #5" page and the request type is "GET"
		Then I should see a JSON object of "users #5"'s "comments"

	Scenario: Create comment as the user
		Given I go to the "comments" page of "user #5" page and the request type is "POST"
		And the POST data is '{message: "this is a comment"}'
		Then I should get "success" response
