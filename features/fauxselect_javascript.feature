@selenium
Feature: Use fauxselect
	In order to select a filter
	As a user
	I want to be able to use the fauxselect thingie

Background:
	Given the following intervals exist:
		|	id	|	camera angle	|	session type	|
		|	1	|	camera1		|	a		|
		|	2	|	camera2		|	b		|
	And I am a regular user who is logged in

Scenario: Making sure the list works to begin with
	When I go to the intervals page
	Then I should see "camera1" within ".display_results"
	And I should see "camera2" within ".display_results"

Scenario: Selecting a session type
	When I go to the intervals page
	And I select "a" from the fauxselect ".session_type_selector"

	Then I should see "camera1" within ".display_results"
	And I should not see "camera2" within ".display_results"
	And I should see "a" within ".session_type_selector .fauxselect_button"

Scenario: Selecting "none"
	When I go to the intervals page
	And I select "none" from the fauxselect ".session_type_selector"

	Then I should see "camera1" within ".display_results"
	And I should see "camera2" within ".display_results"
	And I should see "Click to Select" within ".session_type_selector .fauxselect_button"
