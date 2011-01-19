Feature: Require nda
  In order to ensure that all users read and agree to our NDA and the service is protected
  As a site director
  I want all newly created user to be redirected to a page where they read and agree to the NDA
  
  Background:
    Given a user who has not yet signed the NDA
    Given there is nobody loggedin
    When the user logs in to the site

  Scenario: New user logs in
    Then the user should redirected to a page for NDA authorization
  
  Scenario: New user signs nda
    Given a user is on the nda page
    When the user accepts the nda and hits continue
    Then I should be on the root page
  
