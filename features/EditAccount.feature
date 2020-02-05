Feature: Allow user to edit their account

  Background: I have logged into an admin account
    Given I have created an admin account with email "paul@p.com", username "Pauly", first name "Paul", last name "P", number "524-333-3333", and password "password"
    And I am on the admin login page
    And I have logged in as an admin with email "paul@p.com" and password "password"

  Scenario: Admin edits their account
    When I am on my account page
    And I click the edit account button
    And I change my username to "newUsername"
    Then My account should have username "newUsername"
