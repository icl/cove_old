Feature: User administration
  In order to see all manage the users who can access the sytem
  As a admin
  I want to see a list of all users
  
  Background:
    Given a admin
    Given there is nobody loggedin
    When the admin logs in to the site
    
  Scenario: display list
    Given I am on the user administration page
    Then I should see a list of all users registered in the system
  
  
  
