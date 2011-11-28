Feature:
  In order to have a personal gift list
  As a user
  I want to be able to login

  Scenario: I enter a valid username and password
    Given I have a test user created
    And I am on the login page
    When I fill in 'email' with 'test@domain.com'
    And I fill in 'password' with 'secret'
    And I click the button 'Login'
    Then I should see 'Test User'
    And I should see 'logged in'

  Scenario: I enter invalid username or password
    Given I have a test user created
    And I am on the login page
    When I fill in 'email' with 'test@domain.com'
    And I fill in 'password' with 'invalid'
    And I click the button 'Login'
    Then I should see 'Invalid email or password'
