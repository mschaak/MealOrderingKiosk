# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
meals = [
  { meal_name: "Hamburger on a GF bun", meal_calories: 1500, monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: true, sunday: false, description: 'Gotta luv burgurz w/ gluten free bun', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>false}" },
  { meal_name: "Pepperoni Pizza on a GF crust", meal_calories: 1800, monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, saturday: false, sunday: true, description: 'Cheese and sauce and pepperoni and gluten-free crust', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>false}" },
  { meal_name: "N-ice Cream", meal_calories: 900, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, description: 'Cold chocolate nice-cream goodness', dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>true, :NF=>false, :DF=>true}" },
  { meal_name: "Fried Chicken", meal_calories: 800, monday: true, tuesday: false, wednesday: false, thursday: false, friday: true, saturday: false, sunday: true, description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}" },
  { meal_name: "Sushi", meal_calories: 600, monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, saturday: true, sunday: false, description: 'sushi sushi sushi', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}" },
  { meal_name: "Meatloaf", meal_calories: 3500, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, sunday: false, description: 'Don\'t eat this', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}" },
  { meal_name: "Banana", meal_calories: 14, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, description: 'That one yellow fruit', dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}" },
  { meal_name: "Pasta", meal_calories: 450, monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: false, sunday: true, description: 'Spaghetti with vegetarian tomato sauce made fresh', dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}" },
  { meal_name: "Chickpea burger on a GF bun", meal_calories: 500, monday:false, tuesday: false, wednesday: false, thursday:true, friday: false, saturday: false, sunday: true, description: "A vegan chickpea burger on a gluten free bun. Allergy safe for everyone!", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}" },
  { meal_name: "Dairy-free Meat Lover's Pizza", meal_calories: 600, monday:true, tuesday: false, wednesday: true, thursday: false, friday: true, saturday: true, sunday: false, description: "A dairy free \"cheese\" on a meat lover's pizza", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true }" },
  { meal_name: "Nut-Free tofu stir fry with gluten-free noodles", meal_calories: 900, monday: true, tuesday: true, wednesday: true, thursday: false, friday: false, saturday: true, sunday: true, description: "A nut-free and gluten-free stir fry with tofu and gluten free noodles", dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>true, :NF=>true, :DF=>false}" },
  { meal_name: "Fish and Chips", meal_calories: 1500, monday: false, tuesday: false, wednesday: false, thursday: false, friday: true, saturday: true, sunday: true, description: "Transport yourself to a local British chip shop with this homemade version of a classic meal", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>true}" },
  { meal_name: "Macaroni and Cheese", meal_calories: 850, monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true, sunday: true, description: "This all-American comfort food is lovingly made and baked just like your momma used to make", dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}" },
  { meal_name: "Gluten-free macaroni and \"cheese\"", meal_calories: 400, monday:true, tuesday:true, wednesday: true, thursday: false, friday: false, saturday: false, sunday: true, description: "This twist on a classic comfort food is hand prepared to give you the same comfort as before but in a vegan and gluten free manner", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>true, :NF=>false, :DF=>true}" },
  { meal_name: "French bread and cheese", meal_calories: 550, monday: true, tuesday: true, wednesday: true, thursday: true, friday: false, saturday: false, sunday: false, description: "This classic French breakfast is a perfect start to your day with warm, fresh baked bread and local cheeses", dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>false, :NF=>true, :DF=>false}" }

]

meals.each do |meal|
  Meal.create!(meal)
end


students = [
  { student_first_name: "John", student_last_name: "Doe", student_username: "JDoe", password: "password", password_confirmation: "password", email: "jdoe@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" },
  { student_first_name: "Joe", student_last_name: "Shmoe", student_username: "JShmoe", password: "Password123", password_confirmation: "Password123", email: "jshmoe@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>true, :VGT=>false, :GF=>true, :NF=>false, :DF=>false}" },
  { student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" },
  { student_first_name: "Harry", student_last_name: "Potter", student_username: "HPotter", password: "Hallows123", password_confirmation: "Hallows123", email: "hpotter@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>true, :NF=>false, :DF=>false}" },
  { student_first_name: "Ron", student_last_name: "Weasley", student_username: "RWeasley", password: "passwordabc123", password_confirmation: "passwordabc123", email: "rweasley@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>false}" },
  { student_first_name: "Ginny", student_last_name: "Weasley", student_username: "GWeasley", password: "abc123ABC", password_confirmation: "abc123ABC", email: "gweasley@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>true}" },
  { student_first_name: "George", student_last_name: "Weasley", student_username: "GWeasley2", password: "passwordpassword", password_confirmation: "passwordpassword", email: "gweasley2@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>false, :NF=>true, :DF=>true}" },
  { student_first_name: "Harry", student_last_name: "Potter", student_username: "HPotter2", password: "abc123password", password_confirmation: "abc123password", email: "hpotter2@gmail.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>true, :DF=>false}" }
]


students.each do |student|
  stud = Student.create!(student)
  stud.confirm
end

admins = [
  { admin_username: "Mschaak", password: "admin1", password_confirmation: "admin1", admin_first_name: "Matt", admin_last_name: "Schaak", email: "mschaak@test.com", admin_phonenumber: "555-555-5555" },
  { admin_username: "Hdao", password: "admin2", password_confirmation: "admin2", admin_first_name: "Heather", admin_last_name: "Dao", email: "hdao@test.com", admin_phonenumber: "555-555-5555" },
  { admin_username: "GMiller", password: "password", password_confirmation: "password", admin_first_name: "Garrett", admin_last_name: "Miller", email: "gmiller@test.com", admin_phonenumber: "555-555-5555" },
  { admin_username: "RPreston", password: "PASSWORD123", password_confirmation: "PASSWORD123", admin_first_name: "Rachel", admin_last_name: "Preston", email: "rpreston@test.com", admin_phonenumber: "555-555-5555" },
  { admin_username: "SNGraham", password: "password2", password_confirmation: "password2", admin_first_name: "Sarah", admin_last_name: "Graham", email: "sngraham@test.com", admin_phonenumber: "555-555-5555" }
]


admins.each do |admin|
  adm = Admin.create!(admin)
  adm.confirm
end

orders = [
    { student_id: 1, meal_id: 1, complete: true },
    { student_id: 2, meal_id: 1, complete: true },
    { student_id: 1, meal_id: 2, complete: false },
    { student_id: 1, meal_id: 4, complete: true },
    { student_id: 3, meal_id: 3, complete: true },
    { student_id: 3, meal_id: 3, complete: false },
    { student_id: 1, meal_id: 4, complete: false },
    { student_id: 8, meal_id: 9, complete: false },
    { student_id: 8, meal_id: 10, complete: true },
    { student_id: 7, meal_id: 9, complete: false },
    { student_id: 7, meal_id: 11, complete: false },
    { student_id: 6, meal_id: 13, complete: false },
    { student_id: 6, meal_id: 15, complete: false },
    { student_id: 6, meal_id: 14, complete: true },
    { student_id: 7, meal_id: 14, complete: false },
    { student_id: 7, meal_id: 12, complete: false },
    { student_id: 7, meal_id: 5, complete: true },
    { student_id: 8, meal_id: 13, complete: false },
    { student_id: 8, meal_id: 12, complete: true },
    { student_id: 5, meal_id: 12, complete: false },
    { student_id: 5, meal_id: 12, complete: true },
    { student_id: 5, meal_id: 13, complete: false },
    { student_id: 5, meal_id: 14, complete: true },
    { student_id: 5, meal_id: 11, complete: true },
    { student_id: 7, meal_id: 11, complete: false }

]

orders.each do |order|
  Order.create!(order)
end


