require 'rails_helper'
require 'spec_helper'
require 'date'
RSpec.describe NavigationsController, type: :controller do
  # describe 'When a student is logged in' do
  #   before :each do
  #     @request.env["devise.mapping"] = Devise.mappings[:student]
  #     student_user = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847'})
  #     sign_in :student_user
  #     @current_student = student_user
  #     @current_user = @current_student
  #     puts @current_student.email
  #   end
  #   it 'should route them to their navigation page instead of the homepage' do
  #     expect(redirect_to(root_path)).to redirect_to(navigation_studentnavigation_path)
  #   end
  # end
  describe 'As a student' do
    before :each do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>false, :NF=>false, :DF=>false}" })
      student.confirm
      sign_in student
    end
    it 'I should be redirected to student navigation page rather than the home page' do
      get('home')
      expect(response).to redirect_to(navigation_studentnavigation_path)
    end
    it 'should not be able to go to the admin navigation' do
      get('adminnavigation')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
    it 'should not be able to go to the admin show page' do
      get('admin_show')
      expect(response).to redirect_to root_path
    end
    it 'should be able to view admin show page ' do
      Meal.create!(:meal_name =>"cookies", :meal_calories =>60, :monday => "0", :tuesday => "1", :wednesday =>"0", :thursday => "0", :friday => "1", :saturday =>"0", :sunday =>"1", description: 'Like your grandma makes', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}")
      Order.create!(:student_id => 1, :meal_id => 1, :complete => true)
      get('student_show')
      expect(response).to have_http_status(200)
    end
  end
  describe 'As an admin' do
    before :each do
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
    end
    it 'I should be redirected to admin navigation page rather than the home page' do
      get('home')
      expect(response).to redirect_to(navigation_adminnavigation_path)
    end
    it 'should not be able to go to the student navigation' do
      get('studentnavigation')
      expect(response).to redirect_to root_path
      expect(flash[:warning]).to be_present
    end
    it 'should not be able to go to the student show page' do
      get('student_show')
      expect(response).to redirect_to root_path
    end
    it 'should be able to view admin show page ' do
      get('admin_show')
      expect(response).to have_http_status(200)
    end
  end

end
