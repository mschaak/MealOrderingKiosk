Feature: Allow Admin to add a new meal to the meals database

  Scenario:  Add a new meal
    When I have added a meal with name "Burger", calories "300", days TBS "true", "false", "false", "false", "false", "false", "false", dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}", and description "meaty"
    And I am on the meals home page
    Then I should see a meal list entry with name "Burger", calories "300"
