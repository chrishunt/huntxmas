Feature: Delete one of my gifts
  In order to change my mind
  As a User
  I want to be able to delete gifts

  Background:
    Given I am logged in
    And I have a gift saved

  Scenario: Deleting one of my gifts
    Given I am on my gift list
    When I click the link 'Delete'
    Then I should be on my gift list
    And I should see 'gift has been deleted'
    And I should not see selector '.gift'

  Scenario: Attempting to delete another user's gift
    When I visit another user's gift list
    Then I should not see 'Delete'
