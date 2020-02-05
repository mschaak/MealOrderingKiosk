Feature: Allow UI student to login

  Scenario: UI Student creates account
    When I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"
    Then I should have a student entry with username "Bobby", first name "Bob", and last name "B"

  Scenario: UI student logs in
    Given I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"
    And I am on the student login page

    When I have logged in as a student with email "bobby@b.com" and password "pwpwpw"
    Then I should be logged in as student "Bobby"
