Feature: Require nda
  In order to ensure that all users read and agree to our NDA and the service is protected
  As a site director
  I want all newly created user to be redirected to a page where they read and agree to the NDA
  
  Background:
    Given I have not yet signed the NDA
    And there is nobody logged in
    When I login to the site for the first time

  Scenario: New user logs in
  	Then I should be on the nda page

  Scenario: New user signs nda
    Given I am on the nda page
    When I check "accept"
	And I press "Continue"
    Then I should be on the root page
	And I should see "NDA signed by first@time.com"
  
