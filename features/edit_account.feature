Feature: Edit account details
  In order to change my name, email, or password
  As a user
  I want to be able to edit my account details

  Background:
    Given I am logged in
    When I click the link 'Chris'
    Then I should see 'Name'
    And I should see 'Email'
    And I should see 'Password'

  Scenario: With all account information
    When I fill in 'user_name' with 'Bob'
    And I fill in 'user_email' with 'bob@example.com'
    And I fill in 'user_password' with 'newsecret'
    And I click the button 'Update Account'
    Then I should see 'Your account details have been updated!'
    And I should be on my gift list
    And I should see 'Bob' within '#current-user'

    When I click the link 'Logout'
    And I click the link 'Login'
    And I fill in 'email' with 'bob@example.com'
    And I fill in 'password' with 'newsecret'
    And I click the button 'Login'
    Then I should be on my gift list
    And I should see 'Bob' within '#current-user'

  Scenario: With missing account information
    When I fill in 'user_name' with ''
    And I fill in 'user_email' with ''
    And I fill in 'user_password' with ''
    And I click the button 'Update Account'
    Then I should see 'Sorry! There were errors updating your account.'
    And I should see "Name can't be blank"
    And I should see "Email can't be blank"
    And I should see "Password can't be blank"
