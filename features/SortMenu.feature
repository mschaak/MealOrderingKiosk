Feature: Allow student to sort the menu by meal name or calories

  Background: I have logged into a student account and added meals to the database
    Given I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"
    And I am on the student login page
    And I have logged in as a student with email "bobby@b.com" and password "pwpwpw"

    Given the following meals have been added to the meals database
      | meal_name             | meal_calories | monday | tuesday | wednesday | thursday | friday | saturday | sunday | dietary_restrictions                                         | description    |
      | Hamburger             | 600           | true   | false   | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | meat           |
      | Tacos                 | 200           | false  | true    | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | mexican        |
      | Ice Cream             | 300           | true   | true    | true      | false    | true   | false    | false  | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | vanilla        |
      | Pizza                 | 800           | true   | false   | true      | true     | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | Cheese         |
      | Salad                 | 100           | false  | false   | true      | false    | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>true}   | with lettuce   |
      | Spaghetti             | 500           | true   | true    | true      | true     | false  | true     | true   | {:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>true}  | with meatballs |
      | Sloppy Joe            | 800           | false  | false   | true      | true     | false  | true     | true   | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | sloppy         |

  Scenario: Student sorts menu by meal name
    When I am on the daily menu page
    And I click the meal name header
    Then I should see "Hamburger" before "Tacos"

  Scenario: Student sorts menu by calories
    When I am on the daily menu page
    And I click the calories header
    Then I should see "Tacos" before "Sloppy Joe"
