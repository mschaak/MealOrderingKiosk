Feature: Allow admin to logout

  Background: I have logged into an admin account
    Given I have created an admin account with email "paul@p.com", username "Pauly", first name "Paul", last name "P", number "524-333-3333", and password "password"
    And I am on the admin login page
    And I have logged in as an admin with email "paul@p.com" and password "password"

  Scenario: Admin logs out
    When I have clicked the logout button
    Then I should not be logged in as anyone
