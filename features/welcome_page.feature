Feature: Visitors land on a welcome 
As a visitor
I will be presented with a welcome page
So that I can better understand the site

Scenario: Visiting
	Given I am on the root page
	And there is nobody logged in
	Then I should see "Login" within ".user_info"
	
Scenario: Visiting after logging in
	Given I am a regular user who is logged in
	Then I should see "Logout" within ".user_info"