Feature: interval show
  As a user
  I want to be able to view an interval
  so that I can perform my basic tasks as an ethnographer

  Background: 
    Given an interval exists

  Scenario: user visits the show page
    When I visit the interval show page
    Then I should see the title of the interval
    
