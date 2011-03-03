Feature: Search for an interval
	As a user
	I would like to be able to enter a search
	So I can find intervals that math

	Background:
		Given I am a regular user who is logged in
		And the following intervals exists:
			|	camera angle	|	start time		|	duration		|	session type	|	phrase_type	|
			|	Wayne		|	1-1-2001 01:10:00	|	2m32s			|	solo		|	shadow		|
			|	Wayne		|	1-2-2001 01:10:00	|	3m4s			|	duet		|	light		|
			|	Mirror		|	1-2-2001 01:15:00	|	5m1s			|	trio		|	stuff		|
			|	Mirror		|	1-3-2001 01:15:00	|	1m3s			|	quartet		|	lantern		|

	Scenario: No search terms
		When I am on the intervals page
		Then I should see "Wayne" within ".interval_list"

	Scenario: Search for a camera angle
		When I am on the intervals page
		And I search for "Mirror"
		Then I should see "Mirror" within ".interval_list"
		And I should not see "Wayne" within ".interval_list"

	Scenario: Search for a session type
		When I am on the intervals page
		And I search for "trio"
		Then I should see "trio" within ".interval_list"
		And I should not see "quartet" within ".interval_list"
		
	Scenario: Search for a phrase type
		When I am on the intervals page
		And I search for "light"
		Then I should see "light" within ".interval_list"
		And I should not see "shadow" within ".interval_list"
		
