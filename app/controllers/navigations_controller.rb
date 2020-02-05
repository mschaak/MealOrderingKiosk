class NavigationsController < ApplicationController
  before_filter :current_user
  def home
    if current_student
      redirect_to navigation_studentnavigation_path
    elsif current_admin
      redirect_to navigation_adminnavigation_path
    end
  end

  def adminnavigation
    unless current_admin
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
  end

  def studentnavigation
    unless current_student
      flash[:warning] = 'You do not have permission to view that page.'
      redirect_to root_path
    end
  end

  def admin_show
    if current_admin
      @current_admin = Admin.find_by_admin_username(session[:admin_user])
    else
      redirect_to root_path
    end
  end

  def student_show
    if current_student
      @diet_hash = eval(current_student.dietary_restrictions)
      @current_student = Student.find_by_student_username(session[:student_user])
      @totalCal = 0
      Order.all.each do |order|
        if current_student.id == order.student_id
            meal = Meal.find(order.meal_id)
          @totalCal = @totalCal + meal.meal_calories.to_i
        end
      end
      @todays_calories = 0
      today = current_day
      Order.all.each do |order|
        if (today == order.created_at.strftime('%Y-%m-%d').to_date) and (current_student.id == order.student_id)
          meal = Meal.find(order.meal_id)
          @todays_calories = @todays_calories + meal.meal_calories.to_i
        end
      end
    else
      redirect_to root_path
    end
  end
end
