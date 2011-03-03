@selenium
Feature: Check defintion
	In order to understand what a term means
	As a user
	I want to get a definition when I hover over a term

Background:
	Given the following code exists:
		|	name		|	description	|	coding type		|
		|	practice	|	blah de blah	|	session type		|
	And the following interval exists:
		|	id	|	session type	|
		|	1	|	practice	|
	And I am a regular user who is logged in

Scenario: Getting the definition of a term
	When I go to the intervals page
	And I look up the definition for ".session_type"
	Then I should see "blah de blah"
