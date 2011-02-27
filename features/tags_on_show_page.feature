Feature: Apply terms to an interval
	In order to identify an interval
	As a user
	I want to be able to apply and delete specific term(s) to an interval
	So that I and other users can view terms associated with that interval


Background: 
	Given I am on an interval's show page


		Scenario: Display the selected terms
			Then I should see a list of selected terms for that interval
	
	
		Scenario: Add a Phenomena term
			Then I should see a label for the category Phenomena
			And I should see the list of labels of Phenomena
			
			| Phenomena          |
			| Marking            |
			| Riffing            | 
			| Sketching          |
			| Distributed Memory |
			| Costumes           |
			| Sonification       |
			| Imagery            |
			| Props              |
					
			When I check a label
			Then I should see that label checked
			
			
		Scenario: Deleting a Phenomena term
			Then I should see a label for the category Phenomena
			And I should see the list of labels of Phenomena
			
			| Costumes           |
			| Distributed Memory |
			| Imagery            |
			| Marking            |
			| Props              |
			| Riffing            | 
			| Sketching          |
			| Sonification       |
			
			When I uncheck a label
			Then I should see a message that says "Your request is awaiting admin approval"


		Scenario: Add a People term
			Then I should see a label for the category People
			And I should see the list of labels of People
			
			| Alexander |
			| Agnes     |
			| Anna      |
			| Antoine   |
			| Catarina  |
			| Daniela   |
			| Davide    |
			| Jessica   |
			| Louise    |
			| Michael   |
			| Odette    |
			| Paolo     |
			| Wayne     |
			
			When I check a label
			Then I should see that label checked
			
		
		Scenario: Deleting a People term
			Then I should see a label for the category People
			And I should see the list of labels of People
			
			| Costumes           |
			| Distributed Memory |
			| Imagery            |
			| Marking            |
			| Props              |
			| Riffing            | 
			| Sketching          |
			| Sonification       |
			
			When I uncheck a label
			Then I should see a message that says "Your request is awaiting admin approval"


		Scenario: Add a miscellaneous tag
			When I fill in "new tag" area with "<input>"
			And I press "Add"
			Then I should see "<input>" within the miscellaneous tags
		
		
		Scenario: Delete a miscellaneous tag
			When I deselect a miscellaneous tag
			Then the tag is deleted
			
			
		