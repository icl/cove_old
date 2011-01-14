Feature: Authenticate user
  In order to access the system
  As a user
  I want to submit my user name and password and login to the system.
  
  
  Scenario Outline: Valid Login
    Given a regular_user exists
    When the user enters the correct email and password
    Then they should be successfully logged in to the system
    
  Scenario Outline: Invalid Login credentials
    Given a regular_user exists
    When they user enters an incorrect email or password
    Then the user should not be logged in and should be redirected back to the
    login form
  
  