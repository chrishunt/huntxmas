Feature: Viewing all gift lists
  In order to find gifts for my family
  As a user
  I want to see a list of all other users

  Scenario: Allowed access to use list
    Given I am logged in
    When I visit the users page
    Then I should not see 'Please login'
    Then I should see selector '#users'
    And I should see selector '.user'

  Scenario: Viewing all user names
    Given I am logged in
    And there are 2 test users created
    When I visit the users page
    Then I should see 'Test User 1'
    And I should see 'Test User 2'

  Scenario: Clicking the User list link
    Given I am logged in
    When I click the link 'All Lists'
    Then I should be on the users page

  Scenario: I am not logged in
    When I visit the users page
    Then I should see 'Please login'
    And I should not see 'All Lists'
    And I should be on the login page
