Feature:
  In order to find gifts for my family
  As a user
  I want to see a list of all other users

  Scenario: I am not logged in
    When I visit the users page
    Then I should see 'Please login'
    And I should be on the login page

  Scenario: I am logged in
    Given I am logged in
    When I visit the users page
    Then I should not see 'Please login'
    Then I should see selector '#users'
    And I should see selector '.user'

  Scenario: User's names are visible
    Given I am logged in
    And there are 2 test users created
    When I visit the users page
    Then I should see 'Test User 1'
    And I should see 'Test User 2'

  Scenario: User list link is visible
    Given I am logged in
    When I visit my gift list
    Then I should see 'All Lists'

  Scenario: User list link works correctly
    Given I am logged in
    When I click the link 'All Lists'
    Then I should be on the users page
