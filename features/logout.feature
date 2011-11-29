Feature:
  In order to prevent others from modifying my gift list
  As a user
  I want to be able to logout

  Scenario: Clicking the logout link
    Given I am logged in
    When I click the link 'Logout'
    Then I should be on the login page
    And I should not see 'Logout'
