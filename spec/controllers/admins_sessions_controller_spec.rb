require 'rails_helper'

RSpec.describe Admins::SessionsController, type: :controller do
  describe 'logging in as a student' do
    it 'should set current_user' do
      admin= Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
      expect(subject.current_user).to_not eq(nil)
    end
  end
  describe 'logging out as a student' do
    it 'should clear current_user' do
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      sign_in admin
      sign_out admin
      expect(subject.current_user).to eq(nil)
    end
  end
end
