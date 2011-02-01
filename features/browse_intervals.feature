Feature: Browse Intervals
  In order to find videos that I want to watch
  As a user
  I want to browse through a listing of all the intervals where we have video

Background:
	Given I am a regular user who is logged in
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|	session type	|
		|	Wayne		|	1-1-2001 01:10:00	|	1-1-2001 02:00:00	|	solo		|
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|	session type	|
		|	Wayne		|	1-2-2001 01:10:00	|	1-2-2001 02:00:00	|	duet		|
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|	session type	|
		|	Mirror		|	1-2-2001 01:15:00	|	1-2-2001 02:05:00	|	trio		|
	And the following interval exists:
		|	camera angle	|	start time		|	end time		|	session type	|
		|	Mirror		|	1-3-2001 01:15:00	|	1-3-2001 02:05:00	|	quartet		|

Scenario: Go to browse page
	When I go to the intervals page
	Then I should see 4 results
	And I should see a result with a session type of "solo"
	And I should see a result with a session type of "duet"
	And I should see a result with a session type of "trio"
	And I should see a result with a session type of "quartet"

Scenario: Filter by camera angle
	When I go to the intervals page
	And I follow "Mirror" within "#filters"
	Then I should see 2 results
	And I should see a result with a session type of "trio"
	And I should see a result with a session type of "quartet"

Scenario: Search
	When I go to the intervals page
	And I fill in "search" with "trio" within "#filters"
	And I press "Submit" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "trio"

Scenario: Search and filter by angle
	When I go to the intervals page
	And I fill in "search" with "et" within "#filters"
	And I press "Submit" within "#filters"
	And I follow "Mirror" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "quartet"

Scenario: Filter by angle and search
	When I go to the intervals page
	And I follow "Mirror" within "#filters"
	And I fill in "search" with "et" within "#filters"
	And I press "Submit" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "quartet"

Scenario: Filter by date
	When I go to the intervals page
	And I select "01-01-01" from "date" within "#filters"
	And I press "Submit" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "solo"

Scenario: Filter by date and camera angle
	When I go to the intervals page
	And I select "01-02-01" from "date" within "#filters"
	And I press "Submit" within "#filters"
	And I follow "Mirror" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "trio"

Scenario: Filter by date and camera angle and search
	When I go to the intervals page
	And I select "01-02-01" from "date" within "#filters"
	And I press "Submit" within "#filters"
	And I follow "Mirror" within "#filters"
	And I fill in "search" with "tr" within "#filters"
	And I press "Submit" within "#filters"
	Then I should see 1 result
	And I should see a result with a session type of "trio"
