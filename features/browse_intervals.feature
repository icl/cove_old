Feature: Browse Intervals
  In order to find videos that I want to watch
  As a user
  I want to browse through a listing of all the intervals where we have video

Background:
	Given I am a regular user who is logged in
	And the following intervals exist:
		|	camera angle	|	start time		|	duration		|	session type	|	phrase type	|
		|	Wayne		|	Jan 1 2001 01:10:00	|	2m32s			|	solo		|	shadow		|
		|	Wayne		|	Jan 2 2001 01:10:00	|	3m4s			|	duet		|	foo		|
		|	Mirror		|	Jan 2 2001 01:15:00	|	5m1s			|	trio		|	foo		|
		|	Mirror		|	Jan 3 2001 01:15:00	|	1m3s			|	quartet		|	foo		|

Scenario: Go to browse page
	When I go to the intervals page
	Then I should see a result with a session type of "solo"
	And  I should see a result with a session type of "duet"
	And  I should see a result with a session type of "trio"
	And  I should see a result with a session type of "quartet"

Scenario: Filter by phrase type
	When I go to the intervals page
	And I filter by the phrase type "shadow"

Scenario: Filter by camera angle
	When I go to the intervals page
	And I filter by the camera angle "Mirror"

	Then I should see a result with a session type of "trio"
	And  I should see a result with a session type of "quartet"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"

Scenario: Search
	When I go to the intervals page
	And I search for "trio"

	Then I should see a result with a session type of "trio"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "quartet"
	
Scenario: Search and filter by angle
	When I go to the intervals page
	And I search for "et"
	And I filter by the camera angle "Mirror"

	Then I should see a result with a session type of "quartet"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "trio"
 
Scenario: Filter by angle and search
	When I go to the intervals page
	And I filter by the camera angle "Mirror"
	And I search for "et"

	Then I should see a result with a session type of "quartet"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "trio"

Scenario: Filter by date
	When I go to the intervals page
	And I filter by the start time "01-01-01"

	Then I should see a result with a session type of "solo"

	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "trio"
	And  I should not see a result with a session type of "quartet"

Scenario: Filter by date and camera angle
	When I go to the intervals page
	And I filter by the start time "01-02-01"
	And I filter by the camera angle "Mirror"
	Then I should see a result with a session type of "trio"

	Then I should see a result with a session type of "trio"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "quartet"

Scenario: Filter by date and camera angle and search
	When I go to the intervals page
	And I filter by the start time "01-02-01"
	And I filter by the camera angle "Mirror"
	And I search for "tr"

	Then I should see a result with a session type of "trio"

	And  I should not see a result with a session type of "solo"
	And  I should not see a result with a session type of "duet"
	And  I should not see a result with a session type of "quartet"
