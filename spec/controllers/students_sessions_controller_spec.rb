require 'rails_helper'

RSpec.describe Students::SessionsController, type: :controller do
  describe 'logging in as a student' do
    it 'should set current_user' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222'})
      student.confirm
      sign_in student
      expect(subject.current_user).to_not eq(nil)
    end
  end
  describe 'logging out as a student' do
    it 'should clear current_user' do
      student = Student.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:student_username => "test", :student_first_name => 'test', :student_last_name => 'test', :student_phonenumber => '847-222-2222'})
      sign_in student
      sign_out student
      expect(subject.current_user).to eq(nil)
    end
  end
end
