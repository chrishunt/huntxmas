Feature:
  In order to prevent other users from buying the same gift
  As a user
  I want to mark a gift as purchased

  Scenario: Mark gift as purchased on gift list
    Given I am logged in
    And another user has a gift saved
    When I visit another user's gift list
    And I click the link 'Mark as Purchased'
    Then I should see 'Gift has been marked as purchased!'
    And I should not see 'Mark as Purchased'
    And I should see 'Unmark as Purchased'

  Scenario: Unmark gift as purchased on gift list
    Given I am logged in
    And I have marked another user's gift as purchased
    When I visit another user's gift list
    And I click the link 'Unmark as Purchased'
    Then I should see 'Gift is no longer marked as purchased!'
    And I should not see 'Unmark as Purchased'
    And I should see 'Mark as Purchased'

  Scenario: Attempt to unmark gift as purchased when purchased by another user
    Given I am logged in
    And a third user has marked another gift as purchased
    When I visit another user's gift list
    And I click the link 'Unmark as Purchased'
    Then I should see 'Sorry. You cannot unmark gifts that you did not purchase!'
    And I should see 'Unmark as Purchased'
    And I should not see 'Mark as Purchased'

  Scenario: Not able to see who purhcased my gifts
    Given I am logged in
    And another user has marked one of my gifts as purchased
    When I visit my gift list
    Then I should not see 'Mark as Purchased'
    And I should not see 'Unmark as Purchased'
