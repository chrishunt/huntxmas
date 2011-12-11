Feature: Add a gift to gift list
  In order give my gift buyers many options
  As a user
  I want to be able to add a gift

  Scenario: Clicking the add gift link
    Given I am logged in
    When I click the link 'Add Gift'
    Then I should be on the add gift page

  Scenario: Adding a gift when logged in
    Given I am logged in
    When I visit the add gift page
    And I fill in 'gift_name' with 'Xbox 360'
    And I fill in 'gift_url' with 'http://xbox.com'
    And I click the button 'Add Gift'
    Then I should see 'gift has been added'
    And I should be on my gift list
    And I should see 'Xbox 360'

  Scenario: I am not logged in
    Given I am not logged in
    When I visit the add gift page
    Then I should see 'login to continue'
    And I should not see 'Add Gift'
    And I should be on the login page
