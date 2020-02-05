########### Add, Edit, Delete Meal step definitions ############

Given /^I am on the meals home page$/ do
  visit meals_path
end

When /^I have added a meal with name "(.*?)", calories "(.*?)", days TBS "(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)", "(.*?)", dietary restrictions "(.*?)", and description "(.*?)"$/ do |name, calories, mon, tue, wed, thu, fri, sat, sun, rests, desc|
  #visit new_meal_path
  # fill_in 'Meal Name', with: name
  # fill_in 'Calories', with: calories
  #
  # mon ? check('meal[monday]') : uncheck('monday')
  # tue ? check('meal[tuesday]') : uncheck('tuesday')
  # wed ? check('meal[wednesday]') : uncheck('wednesday')
  # thu ? check('meal[thursday]') : uncheck('thursday')
  # fri ? check('meal[friday]') : uncheck('friday')
  # sat ? check('meal[saturday]') : uncheck('saturday')
  # sun ? check('meal[sunday]') : uncheck('sunday')
  #
  # click_button 'Add'

  Meal.create!(meal_name: name, meal_calories: calories, monday: mon, tuesday: tue, wednesday: wed, thursday: thu, friday: fri, saturday: sat, sunday: sun, dietary_restrictions: rests, description: desc)
end

Then /^I should see a meal list entry with name "(.*?)", calories "(.*?)"$/ do |name, calories|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(name) && tr.has_content?(calories)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

When /^I have deleted a meal with name "(.*?)"$/ do |name|
  click_on "#{name}deleteButton"
end

Then /^I should see a meal list without the name "(.*?)"$/ do |name|
  visit meals_path
  result = false
  all('tr').each do |tr|
    if tr.has_content?(name)
      result = true
      break
    end
  end
  expect(result).to be_falsy
end

When /^I have edited the meal "(.*?)" to change the calories to "(.*?)"$/ do |name, calories|
  find_button("#{name}editButton").click
  fill_in 'Calories', with: calories
  click_button 'Update'
end

############ Order Meal Step Definitions ###########

Given /^I am on the orders page$/ do
  visit orders_path
end

Given /^I am on the order history page$/ do
  visit order_history_path
end

Then /^I should see an order with meal name "(.*?)"$/ do |meal|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(meal)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

Then /^I should see an order with student name "(.*?)" and meal name "(.*?)"$/ do |student, meal|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(student) && tr.has_content?(meal)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

Given /^I placed an order with meal id "(.*?)"$/ do |meal_id|
  Order.create!(student_id: @current_student.id, meal_id: meal_id, complete: false)
end

When /^I place an order with student id "(.*?)" and meal id "(.*?)"$/ do |student_id, meal_id|
  Order.create!(student_id: student_id, meal_id: meal_id, complete: false)
end

When /^I mark the order "(.*?)" from "(.*?)" as completed$/ do |meal, name|
  find_button("#{name}_#{meal}").click
end

When /^I should not see the order "(.*?)" from "(.*?)" in the current orders list$/ do |meal, name|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(name) && tr.has_content?(meal)
      result = true
      break
    end
  end
  expect(result).to be_falsy
end

When /^I choose the meal "(.*?)" and click the order button$/ do |id|
  choose("order[#{id}]")
  click_button 'Order'
end

Then /^I should see an order confirmation page$/ do
  expect(page).to have_current_path(order_show_path)
end

########### Daily Menu Step Definitions ############

Given /^the following meals have been added to the meals database$/ do |meals_table|
  meals_table.hashes.each do |meal|
    Meal.create!(meal)
  end
end

Given /^I am on the daily menu page$/ do
  visit current_menu_path
end

When /^The current day is Monday$/ do
  @current_meals = Meal.where(monday: true)
end

Then /^I should only see meals served on Monday$/ do
  result = true
  all('tr').each do |tr|
    if tr.has_content?('Tacos') || tr.has_content?('Salad') || tr.has_content?('Sloppy Joe')
      result = false
      break
    end
  end
  expect(result).to be_truthy
end

When /^I check the "(.*?)" checkbox$/ do |restrictions|

  uncheck 'restrictions[VGN]'
  uncheck 'restrictions[VGT]'
  uncheck 'restrictions[GF]'
  uncheck 'restrictions[NF]'
  uncheck 'restrictions[DF]'

  restrictions.split(',').each do |res|
    check "restrictions[#{res.lstrip}]"
  end

  click_button 'Refresh'
end

Then /^I should see "(.*?)" meals$/ do |meals|
  result = true
  meals.split(',').each do |meal|
    unless tr.has_content?(meal)
      result = false
      break
    end
  end
  expect(result).to be_truthy
end

When /^I click the meal name header$/ do
  click_link('Name')
end

When /^I click the calories header$/ do
  click_link('Calories')
end

Then /^I should see "(.*?)" before "(.*?)"$/ do |meal1, meal2|
  result = true
  all("tr").each do |tr|
    if tr.has_content?(meal1)
      break
    end
    if tr.has_content?(meal2)
      result = false
      break
    end
  end
  expect(result).to be_truthy
end

############ Account Step Definitions ################

Given /^I have created an admin account with email "(.*?)", username "(.*?)", first name "(.*?)", last name "(.*?)", number "(.*?)", and password "(.*?)"$/ do |email, uname, fname, lname, number, password|
  Admin.create!(email: email, password: password, password_confirmation: password, admin_username: uname, admin_first_name: fname, admin_last_name: lname, admin_phonenumber: number)
end

Then /^I should have an admin entry with username "(.*?)", first name "(.*?)", and last name "(.*?)"$/ do |uname, fname, lname|
  expect(Admin.where(admin_username: uname, admin_first_name: fname, admin_last_name: lname)).to exist
end

Given /^I have created a student account with email "(.*?)", username "(.*?)", first name "(.*?)", last name "(.*?)", number "(.*?)", password "(.*?)", and dietary restrictions "(.*?)"$/ do |email, uname, fname, lname, number, password, rests|
  Student.create!(email: email, password: password, password_confirmation: password, student_username: uname, student_first_name: fname, student_last_name: lname, student_phonenumber: number, dietary_restrictions: rests)
end

Then /^I should have a student entry with username "(.*?)", first name "(.*?)", and last name "(.*?)"$/ do |uname, fname, lname|
  expect(Student.where(student_username: uname, student_first_name: fname, student_last_name: lname)).to exist
end

When /^I am on my account page$/ do
  id = current_student ? @current_student.id : @current_admin.id
  visit "/navigation_show_student.#{id}"
end

Given /^I click the edit account button$/ do
  click_button 'Edit account'
end

When /^I change my username to "(.*?)"$/ do |newUsername|
  fill_in 'Username', with: newUsername

  click_button 'Update'
end

Then /^My account should have username "(.*?)"$/ do |newUsername|
  expect(current_user.username).to eq newUsername
end

Given /^the following orders have been added to the meals database$/ do |orders_table|
  orders_table.hashes.each do |order|
    Order.create!(order)
  end
end

Given /^I am on the student home page$/ do
  visit application_path
end

When /^I have clicked on the history page$/ do
  expect(page).to have_selector(:link_or_button, "History")
  click_on 'History'
end

Then /^I should see meals, "(.*?)", "(.*?)", and "(.*?)" on the current students order history$/ do |meal1, meal2, meal3|
  result = true
  all("tr").each do |tr|
    unless tr.has_content?(meal1) || tr.has_content?(meal2) || tr.has_content?(meal3)
      result = false
      break
    end
  end
  expect(result).to be_truthy
end

############ Login Step Definitions ################

Given /^I am on the admin login page$/ do
  visit new_admin_session_path
end

Given /^I am on the student login page$/ do
  visit new_student_session_path
end

When /^I have logged in as an admin with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'admin_login_email', with: email
  fill_in 'admin_login_password', with: password

  click_button 'login'
end

When /^I have logged in as a student with email "(.*?)" and password "(.*?)"$/ do |email, password|
  fill_in 'student_login_email', with: email
  fill_in 'student_login_password', with: password

  click_button 'login'
end

Then /^I should be logged in as student "(.*?)"$/ do |name|
  expect(@current_student.student_username).to eq name
end

Then /^I should be logged in as admin "(.*?)"$/ do |name|
  expect(@current_admin.admin_username).to eq name
end

########### Logout Step Definitions #############

When /^I have clicked the logout button$/ do
  click_button 'logout_header'
end

Then /^I should not be logged in as anyone$/ do
  @current_admin.nil? && @current_student.nil?
end
