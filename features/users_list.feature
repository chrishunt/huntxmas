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
