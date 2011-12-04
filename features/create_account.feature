Feature:
  In order to have my own list of gifts
  As a User
  I want to be able to create a user account

  Scenario: Finding account creation page
    Given I am on the login page
    When I click the link 'Create Account'
    Then I should be on the account creation page
    And I should see 'Name'
    And I should see 'Email'
    And I should see 'Password'

  Scenario: Creating account
    Given I am on the account creation page
    When I fill in 'user_name' with 'user'
    And I fill in 'user_email' with 'user@domain.com'
    And I fill in 'user_password' with 'password'
    And I click the button 'Create Account'
    Then I should see 'Account created'
    And I should see 'now login'
    And I should be on the login page

  Scenario: Create account with missing information
    Given I am on the account creation page
    When I click the button 'Create Account'
    Then I should see 'Sorry! There were errors creating your account.'
    And I should see "Name can't be blank"
    And I should see "Email can't be blank"
    And I should see "Password can't be blank"
    And I should not see "Password digest"

  Scenario: Creating account with duplicate email
    Given I am on the account creation page
    And I have already created an account with the email 'user@domain.com'
    When I fill in 'user_name' with 'user'
    And I fill in 'user_email' with 'user@domain.com'
    And I fill in 'user_password' with 'password'
    And I click the button 'Create Account'
    Then I should see 'Email has already been taken'
    And I should be on the users page
