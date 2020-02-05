Feature: Allow student to view their order history

  Background: I have logged into a student account and ordered several meals
    Given I have created a student account with email "bobby@b.com", username "Bobby", first name "Bob", last name "B", number "666-666-6666", password "pwpwpw", and dietary restrictions "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}"
    And I am on the student login page
    And I have logged in as a student with email "bobby@b.com" and password "pwpwpw"

    Given the following meals have been added to the meals database
      | meal_name             | meal_calories | monday | tuesday | wednesday | thursday | friday | saturday | sunday | dietary_restrictions                                         | description    |
      | Hamburger             | 600           | true   | false   | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | meat           |
      | Tacos                 | 200           | false  | true    | false     | false    | true   | false    | false  | {:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true} | mexican        |
      | Ice Cream             | 300           | true   | true    | true      | false    | true   | false    | false  | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | vanilla        |
      | Pizza                 | 800           | true   | false   | true      | true     | false  | true     | true   | {:VGN=>true, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}  | Cheese         |

    Given the following orders have been added to the meals database
      | student_id            | meal_id   | complete   |
      | 1                     | 1         | true       |
      | 1                     | 2         | true       |
      | 1                     | 3         | true       |


  Scenario: Student wants to view their order history
    Given I am on the order history page
    Then I should see meals, "Hamburger", "Tacos", and "Ice Cream" on the current students order history
