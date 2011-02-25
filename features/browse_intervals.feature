Feature: Browse Intervals
  In order to find videos that I want to watch
  As a user
  I want to browse through a listing of all the intervals where we have video

Background:
	Given I am a regular user who is logged in
	And the following intervals exist:
		|	camera angle	|	start time		|	duration		|	session type	|	phrase type	|
		|	Wayne		|	1-1-2001 01:10:00	|	2m32s			|	solo		|	shadow		|
		|	Wayne		|	1-2-2001 01:10:00	|	3m4s			|	duet		|	foo		|
		|	Mirror		|	1-2-2001 01:15:00	|	5m1s			|	trio		|	foo		|
		|	Mirror		|	1-3-2001 01:15:00	|	1m3s			|	quartet		|	foo		|

Scenario: Go to browse page
	When I go to the intervals page
	Then show me the page
	Then I should see 4 results
	And I should see a result with a session type of "solo"
	And I should see a result with a session type of "duet"
	And I should see a result with a session type of "trio"
	And I should see a result with a session type of "quartet"

Scenario: Filter by phrase type
	When I go to the intervals page
	And I select "shadow" from "Phrase Type"
	And I press "Update Filters"
	Then I should see 1 result

Scenario: Filter by camera angle
	When I go to the intervals page
	And I select "Mirror" from "Camera Angle"
	And I press "Update Filters"
	Then I should see 2 results
	And I should see a result with a session type of "trio"
	And I should see a result with a session type of "quartet"

Scenario: Search
	When I go to the intervals page
	And I fill in "search" with "trio"
	And I press "Submit" within ".search_box"
	Then I should see 1 result
	And I should see a result with a session type of "trio"
	
Scenario: Search and filter by angle
	When I go to the intervals page
	And I fill in "search" with "et"
	And I press "Submit" within ".search_box"
	And I select "Mirror" from "Camera Angle"
	And I press "Update Filters"
	Then I should see 1 result
	And I should see a result with a session type of "quartet"
 
Scenario: Filter by angle and search
	When I go to the intervals page
	And I select "Mirror" from "Camera Angle"
	And I press "Update Filters"
	And I fill in "search" with "et"
	And I press "Submit" within ".search_box"
	Then I should see 1 result
	And I should see a result with a session type of "quartet"

Scenario: Filter by date
	When I go to the intervals page
	And I select "01-01-01" from "date"
	And I press "Update Filters"
	Then I should see 1 result
	And I should see a result with a session type of "solo"

Scenario: Filter by date and camera angle
	When I go to the intervals page
	And I select "01-02-01" from "date" within "#filters"
	And I press "Update Filters"
	And I select "Mirror" from "Camera Angle"
	And I press "Update Filters"
	Then I should see 1 result
	And I should see a result with a session type of "trio"

Scenario: Filter by date and camera angle and search
	When I go to the intervals page
	And I select "01-02-01" from "date"
	And I select "Mirror" from "Camera Angle"
	And I press "Update Filters"
	And I fill in "search" with "tr" 
	And I press "Submit" within ".search_box"
	Then I should see 1 result
	And I should see a result with a session type of "trio"
