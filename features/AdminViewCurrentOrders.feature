Feature: Allow admin to view current orders being made

  Background: I have logged into an admin account and added meals to the database
    Given I have created an admin account with email "paul@p.com", username "Pauly", first name "Paul", last name "P", number "524-333-3333", and password "password"
    And I am on the admin login page
    And I have logged in as an admin with email "paul@p.com" and password "password"

    Given the following meals have been added to the meals database
      | meal_name             | meal_calories | monday | tuesday | wednesday | thursday | friday | saturday | sunday | dietary_restrictions                                         | description    |
      | Hamburger             | 600           | true   | false   | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | meat           |
      | Tacos                 | 200           | false  | true    | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | mexican        |
      | Ice Cream             | 300           | true   | true    | true      | false    | true   | false    | false  | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | vanilla        |
      | Pizza                 | 800           | true   | false   | true      | true     | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | Cheese         |
      | Salad                 | 100           | false  | false   | true      | false    | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>true}   | with lettuce   |
      | Spaghetti             | 500           | true   | true    | true      | true     | false  | true     | true   | {:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>true}  | with meatballs |
      | Sloppy Joe            | 800           | false  | false   | true      | true     | false  | true     | true   | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | sloppy         |

     And I am on the orders page

  Scenario: Dining employee needs to see current orders being processed
    Given I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"

    When I place an order with student id "0" and meal id "0"
    Then I should see an order with student name "Bobby" and meal name "Hamburger"

  Scenario: Dining employee marks an order as complete
    Given I placed an order with meal id "1"

    When I mark the order "Tacos" from "Paul" as completed
    Then I should not see the order "Tacos" from "Paul" in the current orders list

