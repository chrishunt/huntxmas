Feature:
  In order to change my mind
  As a User
  I want to be able to delete gifts

  Scenario: I am on my gift page
    Given I am logged in
    And I have a gift saved
    And I am on my gift list
    When I click the link 'Delete'
    Then I should be on my gift list
    And I should not see selector '.gift'

  Scenario: I am on another user's gift page
    Given I am logged in
    And I have a gift saved
    When I visit another user's gift list
    Then I should not see 'Delete'
