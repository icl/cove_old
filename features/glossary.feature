Feature: Check Glossary
	In order to deliver the definition of a term to a user
	As a lowly bit of javascript
	I want to submit an ajax request and get the definition of a term, if one exists

Background:
	Given a phenomenon exists with a name of "riffing"

Scenario: Request existent definition
	When I go to the definition page for "riffing"
	Then I should see "Blah de blah riffing" within ".definition_holder"

Scenario: Request nonexistent definition
	When I go to the definition page for "captain picard"
	Then I should not see ".definition_holder"
