Feature: Vistors land on a welcome 
As a vistor
I will be presented with a welcome page
So that I can better understand the site

Scenario: Visiting
	Given I am on the root page
	Then I should see "Login" within ".user_info"
	
Scenario: Visiting after logging in
	Given a regular user exists
   And the user enters the correct email and password
	Then I should see "Logout" within ".user_info"