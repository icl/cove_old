Feature: User creates section in interval
	In order to quickly skip to certain parts of an interval
	As a user
	I want to be able section off intervals with specific tags

Background:
	Given I am a logged-in user
	And I am on the show page
	
Scenario: Before creating new section
	When I click on the show intervals button
	Then I should see previously tagged intervals on the right of the video player
	
Scenario: Creating a new section
	Given I see I the create interval button on the right of the video player
	When I click on the create interval button
	Then I should see a form come under the video player

Scenario: Starting mark
	Given I see the creating interval form
	And the player is playing the video
	When I click on the start mark button
	Then I should should see a tag appear with that time 
	
Scenario: Stopping mark
	Given I see the creating interval form
	And the player is playing the video
	And I already clicked the start mark button
	When I click on the stop mark button
	Then I should see the tag stop at the time

Scenario: Saving tags
	Given I see the creating interval form
	When I type into the description box
	And I click on the save button
	Then I should see the description witht he section time on the right side of the video player

Scenario: Saving section
	Given I already clicked on the start mark button
	When I click on the save button
	Then I should see that section with the start time on the side of the player
	
Scenario: Canceling saving section
	Given I already clicked on the create interval button
	When I click on the cancel button
	Then I should see the form disappear
	And show page returns to original view
	
	