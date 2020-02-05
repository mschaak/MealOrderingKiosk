Feature: Allow Admin to delete a meal from the meals database

Background: meals have been added to database

  Given the following meals have been added to the meals database
    | meal_name             | meal_calories | monday | tuesday | wednesday | thursday | friday | saturday | sunday | dietary_restrictions                                         | description    |
    | Hamburger             | 600           | true   | false   | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | meat           |
    | Tacos                 | 200           | false  | true    | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | mexican        |
    | Ice Cream             | 300           | true   | true    | true      | false    | true   | false    | false  | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | vanilla        |
    | Pizza                 | 800           | true   | false   | true      | true     | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | Cheese         |

  Scenario:  delete a movie
    Given I am on the meals home page

    When I have deleted a meal with name "Tacos"
    Then I should see a meal list without the name "Tacos"
