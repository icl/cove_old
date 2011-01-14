Feature: Authenticate user
  In order to access the system
  As a user
  I want to submit my user name and password and login to the system.
  
  
  Scenario Outline: Valid User attempts to login
    Given context
    When event
    Then outcome
  