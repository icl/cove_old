Feature: Invite user
  In order to add new users to the sytem
  As a admin
  I want to be able to invite new users by email
  
  Background:
    Given a admin
    Given there is nobody loggedin
    When the admin logs in to the site
  
  Scenario: admin invites a new user
    Given the admin is on the invitations page
    When they fill in the email address and submit
    Then there should be a new user in the db
    # Then the user should receive an email
    
  Scenario: user accepts their invitation
    Given a user has received an invitation
    When the user visits the invitation acceptance page
    When the user fills in their new password
   Then the user should be redirected to root
    Then the users should be able to login with their new password
  
