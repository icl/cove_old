Feature: Require nda
  In order to ensure that all users read and agree to our NDA and the service is protected
  As a site director
  I want all newly created user to be redirected to a page where they read and agree to the NDA
  
  Background:
    Given a user who has not yet signed the NDA
    Given there is nobody logged_in
    When the user logs in to the site

  Scenario: New user logs in
    Then I should be on the nda page

  Scenario: New user signs nda
    Given I am on the nda page
    When I check "accept"
	When I press "Continue"
    Then I should be on the root page
  
