Feature: Viewing gift list
  In order to be happy on Christmas
  As a User
  I want to be able to see my gift list

  Scenario: View all gifts
    Given I am logged in
    And I have a gift saved
    When I visit my gift list
    Then I should see selector '#gifts'
    And I should see selector '.gift'

  Scenario: Clicking my gift list link
    Given I am logged in
    And I am on the users page
    When I click the link 'My List'
    Then I should be on my gift list

  Scenario: Viewing gift list when logged out
    Given I have a gift saved
    When I visit my gift list
    Then I should see 'login to continue'
    And I should not see 'My List'
    And I should be on the login page
