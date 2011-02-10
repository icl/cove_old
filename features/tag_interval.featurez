Feature: Manipulate Tags for an interval
	As a user
	I would like to add tags to an interval
	So that others can find content faster
	
	Scenario: Add tags to an interval
		Given the tag "Distributed Memory" exists
		And I am a regular user who is logged in
		And I am the page for an interval
		When I check "Distributed Memory"
		And I press "Update Interval"
		Then the "Distributed Memory" checkbox should be checked
