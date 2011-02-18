@selenium
Feature: Check defintion
	In order to understand what a term means
	As a user
	I want to get a definition when I hover over a term

Background:
	Given the following code exists:
		|	name	|	description		|	coding type		|
		|	riffing	|	Blah de blah riffing	|	phenomenon		|
	And the following interval exists:
		|	id	|	phrase type	|
		|	1	|	riffing		|
	And I am a regular user who is logged in

Scenario: Getting the definition of a term
	When I go to the intervals page
	And I follow "Session 1"
	And I look up the definition for ".phrase_type"
	Then I should see "Blah de blah riffing"
