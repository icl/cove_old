Feature: Search
	In order to perform a full-text search
	As a user
	I want to be able to enter a search term and see a list of results

Scenario: Perform a search and get a result
	Given an interval exists with a camera angle of "Wayne"
	When I am on the root page
	And I search for "Wayne" with the global search
	Then I should be on the intervals page
	And I should see "Wayne" within "#results"
	And I should see 1 result

Scenario: Perform a search and fail to get a result
	When I am on the root page
	And I search for "lkasdmnflkasmdflkansdflkasndflakndf" with the global search
	Then I should be on the intervals page
	And I should see 0 results
	And I should see "There were no videos found with these filter options." within "#results"
