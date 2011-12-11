Feature: Root url for xmas list
  In order to start buying my family gifts
  As a user
  I want to see the user list at the application root

  Scenario: When not logged in
    Given I am not logged in
    When I visit '/'
    Then I should see 'Please login'
    And I should be on the login page

  Scenario: When logged in
    Given I am logged in
    When I visit '/'
    Then I should see selector '#users'
    And I should see selector '.user'
