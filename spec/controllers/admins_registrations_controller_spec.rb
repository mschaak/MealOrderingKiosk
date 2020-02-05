require 'rails_helper'
require 'spec_helper'
RSpec.describe Admins::RegistrationsController, type: :controller do
  describe 'Creating admins account' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      post :create, admin: {:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'}    end
    it 'Should create admins account if inputs are valid' do
      expect(Admin.count).to eq(1)
      expect(response).to have_http_status(302)
      #expect(flash[:notice]).to be_present
    end
    it 'Should not create an admins account if input is not valid' do
      expect {post :create, admin: {:email => "", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847'}}.to_not change{Admin.count}
      expect(flash[:notice]).to be_present
    end
  end

  describe 'Updating admin account' do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = Admin.create!({:email => "test@test.com", :password => "gibson", :password_confirmation =>'gibson',:admin_username => "test", :admin_first_name => 'test', :admin_last_name => 'test', :admin_phonenumber => '847-222-2222'})
      admin.confirm
      sign_in admin
    end
    it 'should change the email' do
      expect {post :update, admin: {:email => "test@test.com", :password => "", :password_confirmation => "",:admin_username => "test", :admin_first_name => 'test1', :admin_last_name  => 'test', :admin_phonenumber => '847-222-2222', :current_password => 'gibson'}}.to_not change{Admin.count}
      expect(Admin.find_by_admin_username("test").admin_first_name).to eq("test1")

    end

  end


end
