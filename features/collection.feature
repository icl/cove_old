Feature: Collection Page
	As a user
	I want be able to create collections
	So I can organize groups of intervals 
	
  Background:
  	Given I am a regular user who is logged in

  Scenario: Visiting the Collections Page
    Given I am on the home page
    When I follow "Collections"
    Then I should be on the collections page

  Scenario: Creating a Collection
	Given I am on the collections page
	And I follow "Create a New Collection"
	When I fill in the following:
	     | Name 		  | Created Collection  |
	     | Description    | Ipsum Lorem		    |
	And I press "Create Collection"
	Then I should be on the page for collection "Created Collection"
	And I should see "Collection was successfully created."
@wip	
  Scenario: Adding an Interval to a Collection
    Given I have a collection
	And I visit the interval page
	When I follow "Session 2"
	And I press "Add to Favorites"
	And I visit the collections page
	And I select "Test Collection"
	Then I should see "Session 2"
@wip
  Scenario: Removing an Interval from a Collection
	Given I am on the collections page
	And I have a collection
	When I select "Test Collection"
	And I select "X"
	Then I should not see "Session 2"
	
  Scenario: Destroying a Collection
	Given I have a collection
	And I am on the collections page
	When I follow "Delete Collection"
	Then I should see "Collection was successfully deleted."