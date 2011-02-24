Feature: Admin Page
  In order to access the admin page
  As an admin user
  I want to make sure that the admin page is usuable

  Scenario: Visiting the Admin Page
    Given I am an admin user
    And I click on the "Admin" link 
    Then I should go to the admin page
