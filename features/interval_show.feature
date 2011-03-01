Feature: interval show
  As a user
  I want to be able to view an interval
  so that I can perform my basic tasks as an ethnographer

  Background: 
		Given I am a regular user who is logged in
    Given an interval exists
    Given there has been a tag applied to the interval
    Given There has been a phenomenon applied
    When I visit the interval show page
    
  Scenario: Basic title Scenario
    Then I should see the title of the interval

  Scenario: Tag list
    Then I should see all the applied tags

  Scenario: Phenomenon List
    Then I should see all the applied phenomenon
    
