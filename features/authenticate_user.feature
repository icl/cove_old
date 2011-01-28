Feature: Authenticate user
  In order to access the system
  As a user
  I want to submit my user name and password and login to the system.
  
  
  Scenario: Valid Login credentials
    Given I am a regular user
    When I enter the correct email and password
    Then I should be on the root page
	And I should see "Signed in successfully."

  Scenario: Invalid Login credentials
    Given I am a regular user
    When I enter an incorrect email or password
	Then I should be on the login page
	And I should see "Invalid email or password."
   