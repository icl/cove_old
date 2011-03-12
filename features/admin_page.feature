Feature: Admin Page
  In order to access the admin page
  As an admin user
  I want to make sure that the admin page is usuable

  Scenario: Visiting the Admin Page
    Given I am an admin user who is logged in
    And I am on the home page
    When I follow "Admin"
    Then I should be on the admin page
