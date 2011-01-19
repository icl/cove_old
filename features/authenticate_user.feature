Feature: Authenticate user
  In order to access the system
  As a user
  I want to submit my user name and password and login to the system.
  
  
  Scenario: Valid Login credentials
    Given a regular user exists
    When the user enters the correct email and password
    Then the user should be successfully logged in and redirected to root path
    
  Scenario: Invalid Login credentials
    Given a regular_user exists
    When the user enters an incorrect email or password
    Then the user should not be logged in and should be redirected back to the login form

   