Feature: Invite user
  In order to add new users to the system
  As a admin
  I want to be able to invite new users by email
  
  Background:
    Given I am an admin
    Given there is nobody logged in
    When I log into the site as an admin

  Scenario: admin invites a new user
	Given I am on the invitations page
    When I fill in the email address and submit
    Then there should be a new user in the db
        # Then the user should receive an email
    
  Scenario: user accepts their invitation
    Given I have received an invitation
    When I visit the invitation acceptance page
    And I fill in my new password
    Then I should be on the nda page
    And I should be able to login with my new password
  
