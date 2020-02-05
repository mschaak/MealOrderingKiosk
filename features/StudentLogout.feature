Feature: Allow student to logout

  Background: I have logged into an admin account
    Given I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"
    And I am on the student login page
    And I have logged in as a student with email "bobby@b.com" and password "pwpwpw"

  Scenario: Student logs out
    When I have clicked the logout button
    Then I should not be logged in as anyone
