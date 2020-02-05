require 'rails_helper'
require 'spec_helper'
RSpec.describe Students::RegistrationsController, type: :controller do
  describe 'Creating student account' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      @student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222'})
      @student.confirm
    end
    it 'Should create student account if inputs are valid' do
      expect(Student.count).to eq(1)
      expect(response).to have_http_status(200)
      #expect(flash[:notice]).to be_present
    end
    it 'create account with restrictions' do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      student = Student.create!({:email => "test1@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', :VGN=>'1', :VGT=>'1', :GF=>'1', :NF=>'1', :DF=>'1'})
      student.confirm
      expect(Student.count).to eq(2)
      post :create, student: {:email => "test2@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222', :VGN=>'1', :VGT=>'1', :GF=>'1', :NF=>'1', :DF=>'1'}
      expect(response).to have_http_status(302)
    end
    it 'Should not create a student account if input is not valid' do
      expect {post :create, student: {:email => "", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847'}}.to_not change{Student.count}
      #expect(flash[:notice]).to be_present
    end
  end

  describe 'Updating student account' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:student]
      @student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222'})
      @student.confirm
      sign_in @student
    end
    it 'should change the email' do
      expect {post :update, student: {:email => "test@test.com", :password => "", :password_confirmation => "",:student_username => "test", :student_first_name => 'test1', :student_last_name  => 'test', :student_phonenumber => '847-222-2222', :current_password => 'gibson',:VGN=>'1', :VGT=>'1', :GF=>'1', :NF=>'1', :DF=>'1'}}.to_not change{Student.count}
      expect(Student.find_by_student_username("test").student_first_name).to eq("test1")

    end
    it "should change username" do

    end
  end
end
