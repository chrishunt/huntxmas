Feature:
  In order to have a personal gift list
  As a user
  I want to be able to login

  Scenario: Clicking the login link
    Given I am on the login page
    When I click the link 'Login'
    Then I should be on the login page

  Scenario: I enter a valid username and password
    Given there are 1 test users created
    And I am on the login page
    When I fill in 'email' with 'test_user1@domain.com'
    And I fill in 'password' with 'secret'
    And I click the button 'Login'
    Then I should see 'Test User 1'
    And I should see 'logged in'

  Scenario: I enter invalid username or password
    Given there are 1 test users created
    And I am on the login page
    When I fill in 'email' with 'test_user1@domain.com'
    And I fill in 'password' with 'invalid'
    And I click the button 'Login'
    Then I should see 'Invalid email or password'
