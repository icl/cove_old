Feature: Filtering Interval results
	In order to find more relevant videos
	As a log-in user
	I want to be able to narrow down interval results

Background:
	Given I am a logged-in user
	And I am on the intervals_index page

Scenario: Filtering for Camera angle: Any
	When I click any
	Then I should see Daily 1, Mirror, Rear 1, Rear 2, or Wayne under camera angle for all results

Scenario: Filtering for Camera angle: Daily 1
	When I click Daily 1
	Then I should see Daily 1 under camera angle for all results
	
Scenario: Filtering for Camera angle: Mirror
	When I click Mirror
	Then I should see Mirror under camera angle for all results

Scenario: Filtering for Camera angle: Rear 1
	When I click Rear 1
	Then I should see Rear 1 under camera angle for all results

Scenario: Filtering for Camera angle: Rear 2
	When I click Rear 2
	Then I should see Rear 2 under camera angle for all results

Scenario: Filtering for Camera angle: Wayne
	When I click Wayne
	Then I should see Wayne under camera angle for all results

Scenario: Filtering for specific date
	When I select 23-9-10
	Then I should see results dated Thursday September 23, 2010 for all results

Scenario: Decreasing number of results
	When I filter results
	Then I should see the number of results go down

Scenario: Increasing number of results
	When I take away filters
	Then I should see the numbers of results go up

	
