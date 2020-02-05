Feature: Allow Admin to login

  Scenario: Admin creates account
    When I have created an admin account with email "paul@p.com", username "Pauly", first name "Paul", last name "P", number "524-333-3333", and password "password"
    Then I should have an admin entry with username "Pauly", first name "Paul", and last name "P"

  Scenario: Admin logs in
    Given I have created an admin account with email "paul@p.com", username "Pauly", first name "Paul", last name "P", number "524-333-3333", and password "password"
    And I am on the admin login page

    When I have logged in as an admin with email "paul@p.com" and password "password"
    Then I should be logged in as admin "Pauly"
