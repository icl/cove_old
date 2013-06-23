Feature: Interaction with Search Results
	In order to view selected intervals
	As a user
	I want to be able to click links that will take me to the show_page

Background:
	Given I am a log-in user
	And I am on the intervals_index page

Scenario: Clicking on the Session number
	When I click on the session number
	Then I should be taken to the show_page for that interval

Scenario: Clicking on the Show more Information link
	When I click on the more information link
	Then I should be taken to the show_page for that interval
	
Scenario: Clicking on the arrow
	When I click on the arrow corresponding to a interval result
	Then I should be taken to the show_page for that interval 

