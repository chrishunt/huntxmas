Feature:
  In order to be happy on Christmas
  As a User
  I want to be able to see my gift list

  Scenario: Logged out
    Given I have a gift saved
    When I visit my gift list
    Then I should see 'login to continue'
    And I should not see 'My List'
    And I should be on the login page

  Scenario: View all gifts
    Given I am logged in
    And I have a gift saved
    When I visit my gift list
    Then I should see selector '#gifts'
    And I should see selector '.gift'

  Scenario: My gift list link is visible
    Given I am logged in
    When I visit the users page
    Then I should see 'My List'

  Scenario: My gift list link works
    Given I am logged in
    And I am on the users page
    When I click the link 'My List'
    Then I should be on my gift list

