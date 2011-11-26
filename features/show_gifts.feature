Feature:
  In order to be happy on Christmas
  As a User
  I want to be able to see my gift list

  Scenario: View all gifts
    Given I have a gift saved
    When I visit my gift list
    Then I should see selector '#gifts'
    And I should see selector '.gift'
