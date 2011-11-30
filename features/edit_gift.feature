Feature:
  In order to change my mind
  As a user
  I want to be able to edit my gifts

  Scenario: Edit link is visible
    Given I am logged in
    And I have a gift saved
    When I visit my gift list
    Then I should see 'edit' within '.gift'

  Scenario: Edit link works
    Given I am logged in
    And I have a gift saved
    And I am on my gift list
    When I click the link 'edit'
    Then I should be on the gift edit page

  Scenario: Edit updates gift in gift list
    Given I am logged in
    And I have a gift saved
    And I am on the gift edit page
    When I fill in 'gift_name' with 'Xbox 360'
    And I fill in 'gift_url' with 'http://xbox.com'
    And I click the button 'Save Gift'
    Then I should be on my gift list
    And I should see 'Your gift has been updated!'
    And I should see 'Xbox 360'
