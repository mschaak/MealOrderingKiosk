Feature: Allow Admin to edit a meal in the meals database

  Scenario:  edit a meal
    When I have added a meal with name "Burger", calories "300", days TBS "true", "false", "false", "false", "false", "false", "false", dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}", and description "meaty"
    And I am on the meals home page

    When I have edited the meal "Burger" to change the calories to "400"
    Then I should see a meal list entry with name "Burger", calories "400"
