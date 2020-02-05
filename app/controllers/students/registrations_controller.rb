# frozen_string_literal: true

class Students::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  def sign_up_params
    params.require(:student).permit(:email, :password, :password_confirmation, :student_username, :student_first_name, :student_last_name, :student_phonenumber)
    diet_hash = Hash.new
    if params[:student][:VGN] == "1"
      diet_hash[:VGN] = true
    else
      diet_hash[:VGN] = false
    end
    if params[:student][:VGT] == "1"
      diet_hash[:VGT] = true
    else
      diet_hash[:VGT] = false
    end
    if params[:student][:GF] == "1"
      diet_hash[:GF] = true
    else
      diet_hash[:GF] = false
    end
    if params[:student][:NF] == "1"
      diet_hash[:NF]= true
    else
      diet_hash[:NF]= false
    end
    if params[:student][:DF] == "1"
      diet_hash[:DF] = true
    else
      diet_hash[:DF] = false
    end
    diet_hash = diet_hash.to_s
    returnHash = {:email => params[:student][:email], :password => params[:student][:password], :password_confirmation => params[:student][:password_confirmation], :student_username => params[:student][:student_username], :student_first_name => params[:student][:student_first_name], :student_last_name => params[:student][:student_last_name], :student_phonenumber => params[:student][:student_phonenumber], :dietary_restrictions => diet_hash}
  end

  def account_update_params
    @temp_hash = current_student.dietary_restrictions
    @diet_hash = eval(@temp_hash)
    params.require(:student).permit(:email, :password, :password_confirmation,:student_username, :student_first_name, :student_last_name, :student_phonenumber, :current_password)
    diet_hash = Hash.new
    if params[:student][:VGN] == "1"
      diet_hash[:VGN] = true
    else
      diet_hash[:VGN] = false
    end
    if params[:student][:VGT] == "1"
      diet_hash[:VGT] = true
    else
      diet_hash[:VGT] = false
    end
    if params[:student][:GF] == "1"
      diet_hash[:GF] = true
    else
      diet_hash[:GF] = false
    end
    if params[:student][:NF] == "1"
      diet_hash[:NF]= true
    else
      diet_hash[:NF]= false
    end
    if params[:student][:DF] == "1"
      diet_hash[:DF] = true
    else
      diet_hash[:DF] = false
    end
    diet_hash = diet_hash.to_s
    returnHash = {:email => params[:student][:email], :password => params[:student][:password], :password_confirmation => params[:student][:password_confirmation], :student_username => params[:student][:student_username], :student_first_name => params[:student][:student_first_name], :student_last_name => params[:student][:student_last_name], :student_phonenumber => params[:student][:student_phonenumber], :dietary_restrictions => diet_hash, :current_password =>  params[:student][:current_password]}
  end
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
   def edit
     @temp_hash = current_student.dietary_restrictions
     @diet_hash = eval(@temp_hash)
   end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
