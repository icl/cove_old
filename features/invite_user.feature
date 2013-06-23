Feature: Invite user
  In order to add new users to the system
  As admin
  I want to be able to invite new users by email
  
  Background:
    Given I am an admin
    Given I am not logged in
    When I log into the site as admin
    
  Scenario: admin views list
  	Given I am on the invitations page
    Then I should see user's invitations list
    And I should see invitee's invitations status

  Scenario: admin invites a new user
	Given I am on the invitations page
	And I see list of users on invitation list
    When I fill in the email address and submit
    Then there should be a new user in the db
    And the user should receive an email

  Scenario: user ignores their invitation
  	Given I invite a new user
  	And new user ignores invitation
  	Then invitations list shows how many days since pending
  
  	#receiving user's perspective
  Scenario: user accepts their invitation
    Given I have received an invitation
    When I visit the invitation acceptance page
    And I fill in my new password
    Then I should be on the nda page
    And I should be able to login with my new password
    Then admin should see an update to invitations list
    And the user's name should be highlighted

  	#receiving user's perspective
  Scenario: admin invites wrong user
  	Given I have received an invitation
    When I visit the invitation acceptance page
    And I fill in my new password
    Then I should be on an apology page
    And I should see contact info
    