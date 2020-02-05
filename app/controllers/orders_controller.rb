# frozen_string_literal: true

require 'twilio-ruby'

class OrdersController < ApplicationController
  before_filter :current_user
  def order_params
    params.require(:order).permit(:student_id, :meal_id, :complete)
  end

  def new
    # used by STUDENT to make new orders
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
  end

  def create
    # used by STUDENT to make new orders
    if params[:order].nil?
      flash[:warning] = 'You must select a meal to submit an order.'
      redirect_to current_menu_path
    else
      begin
      params[:order][:student_id] = @current_student.id
      params[:order][:complete] = false
      sendConfirm
      @order = Order.create!(order_params)
      redirect_to order_path(@order)
      rescue Exception => e
        flash[:warning] = 'An unexpected error occurred, your phone number may not be valid'
        redirect_to root_path
        end
    end
  end

  def show
    # used by students as Order confirmation page?
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    @current_order = Order.find(params[:id])
  end

  def index
    # this should be used by the admins to display all current orders
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    sort = params[:sort] || session[:sort]
    case sort
    when 'time'
      ordering, @time_header = {:created_at => :asc }, 'hilite'
    end
    @orders = Order.all.where(complete: false).order(ordering)
  end

  def edit
    # maybe used by ADMIN to mark orders complete?
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
  end

  def update
    begin
    # Used by ADMIN to mark orders complete
    @order = Order.find(params[:id])
    @order.update_attributes!(complete: true)
    sendText
    flash[:notice] = "#{@order.meal.meal_name} for #{@order.student.student_username} has been finished."
    redirect_to orders_path
    rescue Exception => e
      flash[:warning] = 'An unexpected error occurred'
      redirect_to root_path
      end
  end

  def destroy
    # may not be needed - unless we want to cancel orders or clear order history
  end

  def order_history
    # used by STUDENT to show their past orders
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
    @current_student = Student.find_by_student_username(session[:student_user])
    @orders_list = []
    @student_orders = Hash.new
    @student_order_counter = Hash.new(0)
    Order.all.each do |order|
      if current_student.id == order.student_id
        meal = Meal.find(order.meal_id)
        @student_orders[meal.meal_name] = meal.meal_calories
        @student_order_counter[meal.meal_name] +=1
        @orders_list << order
      end
    end
    @totalCal = 0
    Order.all.each do |order|
      if current_student.id == order.student_id
        meal = Meal.find(order.meal_id)
        @totalCal = @totalCal + meal.meal_calories.to_i
      end
    end
  end

  def sendText
    account_sid = Rails.application.secrets.account_sid # Your Test Account SID from www.twilio.com/console/settings
    auth_token = Rails.application.secrets.auth_token # Your Test Auth Token from www.twilio.com/console/settings
    student_id = @order.student_id
    @std = Student.find(student_id)
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
      body: @std.student_first_name + " your meal is ready. Please pick it up.",
      to:@std.student_phonenumber, # Replace with your phone number
      from: Rails.application.secrets.sender
    ) # Use this Magic Number for creating SMS

    puts message.sid
  end
  def sendConfirm
    account_sid = Rails.application.secrets.account_sid # Your Test Account SID from www.twilio.com/console/settings
    auth_token = Rails.application.secrets.auth_token # Your Test Auth Token from www.twilio.com/console/settings
    #student_id = @order.student_id
    #@std = Student.find(student_id)
    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
      body: @current_student.student_first_name + ", your order has been placed and is currently being prepared.",
      to:@current_student.student_phonenumber, # Replace with your phone number
      from: Rails.application.secrets.sender
    ) # Use this Magic Number for creating SMS

    puts message.sid
  end
end
