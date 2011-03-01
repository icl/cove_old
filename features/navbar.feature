Feature: a navbar
	As any user
	I want a link to the intervals in the main navbar
	So that I can quickly jump to that page
	
WHO
WHAT
WHY

As a
I want
So that

	Scenario: user visits welcome page
		Given I am on the root page
		Then I should not see "Browse"
		
	Scenario: user clicks intervals link
		Given a regular user exists
		When I am on the intervals page
	    When I enter the correct email and password
		Then I should see "Browse"
		When I follow "Browse"
		Then I should be on the intervals page
		