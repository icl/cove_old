Feature: Browse Intervals
  In order to find videos that I want to watch
  As a user
  I want to browse through a listing of all the intervals where we have video


Background:
	Given a regular user exists
   And the user enters the correct email and password

Scenario: Go to browse page
	When I go to the intervals page
