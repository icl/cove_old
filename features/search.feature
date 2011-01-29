Feature: Search
	In order to perform a full-text search
	As a user
	I want to be able to enter a search term and see a list of results

Scenario: Perform a search
	When I am on the root page
	And I search for "Wayne" with the global search
	Then I should be on the intervals page
