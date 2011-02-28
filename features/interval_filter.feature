Feature: Filter Intervals
As a user
I want to pick filters for intervals
So I can eliminate irrelevant intervals

	Background:
		Given I am a regular user who is logged in
		And the following intervals exists:
			|	camera angle	|	start time		|	duration		|	session type	| phrase_type |
			|	Wayne		|	1-1-2001 01:10:00	|	2m32s			|	solo		| shadow|
			|	Wayne		|	1-2-2001 01:10:00	|	3m4s			|	duet		| light |
			|	Mirror		|	1-2-2001 01:15:00	|	5m1s			|	trio		| stuff |
			|	Mirror		|	1-3-2001 01:15:00	|	1m3s			|	quartet		| lantern |
	Scenario: Filter By Camera Angle
		Given I am on the intervals page
		When I follow "Wayne" within ".filter"
		Then I should see "Wayne" within ".interval_list"
		And I should not see "Mirror" within ".interval_list"

	Scenario: Filter By Session Type
		Given I am on the intervals page
		When I follow "solo" within ".filter_session_type"
		Then I should see "solo" within ".interval_list"
		And I should not see "duet" within ".interval_list"