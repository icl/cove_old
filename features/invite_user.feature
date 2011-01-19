Feature: Invite user
  In order to add new users to the sytem
  As a admin
  I want to be able to invite new users by email
  
  Background:
    Given a admin
    When the admin logs in to the site
  
  Scenario: admin invites a new user
    Given the admin is on the invitations page
    When they fill in the email address and submit
    Then the user should receive an email
    Then there should be a new user in the db
  
