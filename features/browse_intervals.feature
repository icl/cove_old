Feature: Browse Intervals
  In order to find videos that I want to watch
  As a user
  I want to browse through a listing of all the intervals where we have video

Background:
	Given I am a regular user who is logged in
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|
		|	Wayne		|	1-1-2001 01:10:00	|	1-1-2001 02:00:00	|
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|
		|	Wayne		|	1-2-2001 01:10:00	|	1-2-2001 02:00:00	|
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|
		|	Mirror		|	1-2-2001 01:15:00	|	1-2-2001 02:05:00	|

Scenario: Go to browse page
	When I go to the intervals page
	Then I should see 3 results
	And I should see "Wayne" within "#results"
	And I should see "Mirror" within "#results"

Scenario: Filter by camera angle
	When I go to the intervals page
	And I follow "Mirror" within "#filters"
	Then I should see 1 result
	And I should see "Mirror" within "#results"
