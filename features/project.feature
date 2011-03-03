Feature: Project Page
	As a user
	I want be able to create projects
	So I can organize my research
	
  Background:
  	Given I am a regular user who is logged in

  Scenario: Visiting the Projects Page
    Given I am on the home page
    When I follow "Projects"
    Then I should be on the projects page

  Scenario: Creating the first Project
	Given I have no projects
	And I am on the home page
	When I follow "Projects"
	When I fill in the following:
	     | Name 		  | First Project |
	     | Description    | Ipsum Lorem	  |
    And I press "Submit"
    Then I should be on the page for project "First Project"
	
  Scenario: Creating a Project
	Given I have a project
	And I am on the projects page
	When I follow "Create a new project"
	And I fill in the following:
	     | Name 		  | Created Project  |
	     | Description    | Ipsum Lorem	     |
	And I press "Submit"
	Then I should be on the page for project "Created Project"
	
  Scenario: Visiting a Project Page
	Given I have a project
	And I am on the projects page
	When I follow "Factory Project"
	Then I should be on the page for project "Factory Project"

  # The following commented scenarios do not have functionality yet
  #Scenario: Adding a Collection to a Project # To be added later
	
  #Scenario: Removing a Collection to a Project # To be added later
	
  Scenario: Destroying a Project
	Given I have a project
	And I am on the projects page
	When I follow "Factory Project"
	And I follow "Destroy"
	Then I should be on the projects page
	And I should see "Project was successfully deleted"