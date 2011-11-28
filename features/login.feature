Feature:
  In order to have a personal gift list
  As a user
  I want to be able to login

  Scenario: I already have an account
    Given I have an account created
    And I am on the login page
    When I fill in 'email' with 'user1@domain.com'
    And I fill in 'password' with 'secret'
    And I click the button 'Login'
    Then I should see 'user1'
    And I should see 'logged in'
