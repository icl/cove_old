Feature: Require nda
  In order to ensure that all users read and agree to our NDA and the service is protected
  As a site director
  I want all newly created user to be redirected to a page where they read and agree to the NDA

  Scenario: new user logs in
    Given a user who has not yet signed the NDA
    When the user logs in to the site
    Then the user should redirected to a page for NDA authorization
  
  
  
