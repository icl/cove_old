Feature: Search for an interval
	As a user
	I would like to be able to enter a search
	So I can find intervals that math

	Background:
		Given I am a regular user who is logged in
		And the following interval exists:

			|	camera angle	|	start time		|	duration		|	session type	| phrase_type |
			|	Wayne		|	1-1-2001 01:10:00	|	2m32s			|	solo		| shadow|
		And the following interval exists:
			|	camera angle	|	start time		|	duration		|	session type	|
			|	Wayne		|	1-2-2001 01:10:00	|	3m4s			|	duet		|
		And the following interval exists:
			|	camera angle	|	start time		|	duration		|	session type	|
			|	Mirror		|	1-2-2001 01:15:00	|	5m1s			|	trio		|
		And the following interval exists:
			|	camera angle	|	start time		|	duration		|	session type	|
			|	Mirror		|	1-3-2001 01:15:00	|	1m3s			|	quartet		|
@javascript
	Scenario: Search for a camera angle
		When I am on the root page
		And I fill in "search_box" with "Mirror"
		And I press "Search"
		Then I should see "Mirror" within ".interval_list"
		And I should not see "Wayne" within ".interval_list"
	