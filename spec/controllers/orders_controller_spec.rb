require 'rails_helper'
require 'spec_helper'
RSpec.describe OrdersController, type: :controller do
  describe 'Create an order' do
    it 'should successfully create an order' do
      student = Student.create!({ student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "224-678-8311", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" })
      student.confirm
      sign_in student
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>"60", :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      meal_id = x.id
      post :create, order: {:meal_id => meal_id, :complete => false, :student_id => 1}
      expect(Order.count).to eq(1)
    end
  end
  describe 'update an order' do
    it 'should update the completed column' do
      student = Student.create!({ student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "224-678-8311", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" })
      student.confirm
      sign_in student
      x = Meal.create!(:meal_name =>"cookies", :meal_calories =>"60", :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      meal_id = x.id
      order = Order.create!({:meal_id => meal_id, :complete => false, :student_id => 1})
      order_id = order.id
      put :update, :id => 1
      expect(Order.find(1).complete).to eq(true)
    end
  end
  describe 'show student order history' do
    it 'should display a history of orders' do
      student = Student.create!({ student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "224-678-8311", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" })
      student.confirm
      sign_in student
      Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      Order.create!(:student_id => 1, :meal_id => 1, :complete => true)
      get('order_history')
      expect(response).to have_http_status(200)
    end
  end
  describe 'As an admin' do
    before :each do
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
    end
    it 'should not be able to create an order ' do
      get('new')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
    it 'should not be able to go to order history page ' do
      get('order_history')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
  end
  describe 'As a student' do
    before :each do
      student = Student.create!({ student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "224-678-8311", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" })
      student.confirm
      sign_in student
    end
    it 'should not be able to view order index page ' do
      get('index')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
    # it 'should not be able to view order index page ' do
    #   Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
    #   Order.create!(:student_id => 1, :meal_id => 1, :complete => false)
    #   get :edit, params: {}
    #   expect(response).to redirect_to root_path
    #   expect(flash[:warning]).to be_present
    # end
  end
end
