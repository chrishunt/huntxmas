Feature: Edit gift details
  In order to change my mind
  As a user
  I want to be able to edit my gifts

  Background:
    Given I am logged in
    And I have a gift saved

  Scenario: Clicking the edit gift link
    Given I am on my gift list
    When I click the link 'Edit'
    Then I should be on the gift edit page

  Scenario: Updating the details of a gift
    Given I am on the gift edit page
    When I fill in 'gift_name' with 'Xbox 360'
    And I fill in 'gift_url' with 'http://xbox.com'
    And I click the button 'Save Gift'
    Then I should be on my gift list
    And I should see 'Your gift has been updated!'
    And I should see 'Xbox 360'

  Scenario: Attempting to edit another user's gift
    When I visit another user's gift list
    Then I should not see 'Edit'

