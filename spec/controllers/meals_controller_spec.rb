require 'rails_helper'
require 'spec_helper'
require 'date'
RSpec.describe MealsController, type: :controller do
  describe 'Creating a meal' do
    it 'should successfully create a meal' do
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}"}
      expect(Meal.count).to eq(1)
    end
    it 'add meal with restrictions' do
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', :VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}
      expect(Meal.count).to eq(1)
    end
    it 'should fail when a student or anyone else tries to make one' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
      get :new, params: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', :VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
    it 'should cause not create duplicates' do
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}"}
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}"}
      expect(Meal.count).to eq(1)
    end
  end
  describe 'Updating a meal' do
    it 'should change the calories' do
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}"}
      expect(Meal.count).to eq(1)
      put :schedule, :id => 1, :meal => {:meal_name =>"cookies", :meal_calories =>500, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}"}
      expect(Meal.find_by_meal_name("cookies").meal_calories).to eq(500)
    end
    it 'add meal with restrictions' do
      post :create, meal: {:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', :VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}
      put :schedule, :id => 1, :meal =>{:meal_name =>"cookies", :meal_calories =>500, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', :VGN=>true, :VGT=>true, :GF=>true, :NF=>true, :DF=>true}
      expect(Meal.find_by_meal_name("cookies").meal_calories).to eq(500)
      expect(Meal.count).to eq(1)
    end
  end
  describe 'Deleting a meal' do
    it 'should successfully delete a meal' do
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      expect(Meal.count).to eq(1)
      delete :destroy, {:id => x.id}
      expect(Meal.count).to eq(0)
      #       # expect(response).to redirect_to(meal_path)
      #       # expect(flash[:notice]).to be_present
    end
  end
  describe 'Render the current menu' do
    it 'should display only meals that are for tuesday' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
      y = Meal.create!(:meal_name =>"burgers", :meal_calories =>500, :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      z = Meal.create!(:meal_name =>"salad", :meal_calories =>20, :monday => "0", :tuesday => "0", :wednesday =>"0", :thursday => "0", :friday => "0", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      allow(Date). to receive(:today).and_return Date.new(2019, 11, 19)
      controller.current_menu
      expect(controller.instance_variable_get(:@current_meals)).to eq([y, x])
      expect(controller.instance_variable_get(:@current_meals).length).to eq(2)
    end
    it 'should only display foods that meet the students dietary restrictions' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
      y = Meal.create!(:meal_name =>"burgers", :meal_calories =>500, :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>true, :NF=>false, :DF=>true}")
      z = Meal.create!(:meal_name =>"salad", :meal_calories =>20, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "0", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>true, :GF=>true, :NF=>false, :DF=>true}")
      allow(Date). to receive(:today).and_return Date.new(2019, 11, 19)
      controller.current_menu
      expect(controller.instance_variable_get(:@current_meals)).to eq([x, z])
    end

  end
  describe 'Render tomorrows menu' do
    it 'should render wednesday menu' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
      y = Meal.create!(:meal_name =>"burgers", :meal_calories =>500, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      z = Meal.create!(:meal_name =>"salad", :meal_calories =>20, :monday => "0", :tuesday => "0", :wednesday =>"1", :thursday => "0", :friday => "0", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      allow(Date). to receive(:today).and_return Date.new(2019, 11, 19)
      controller.tomorrows_menu
      expect(controller.instance_variable_get(:@current_meals)).to eq([x, z])
      expect(controller.instance_variable_get(:@current_meals).length).to eq(2)
    end
    it 'should redirect you to home if you are not a student' do
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
      get('tomorrows_menu')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
  end
  describe 'Render meal index' do
    it 'should display all meals if admin is logged in' do
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>"60", :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>true}")
      y = Meal.create!(:meal_name =>"burgers", :meal_calories =>"500", :monday => "0", :tuesday => "1", :wednesday =>"1", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>true}")
      z = Meal.create!(:meal_name =>"salad", :meal_calories =>"20", :monday => "0", :tuesday => "0", :wednesday =>"1", :thursday => "0", :friday => "0", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>true, :DF=>true}")
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
      controller.index
      expect(controller.instance_variable_get(:@meals)).to eq([x, y, z])
    end
    it 'should redirect you to the home page if the user is not an admin' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
      get('index')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
  end

end
