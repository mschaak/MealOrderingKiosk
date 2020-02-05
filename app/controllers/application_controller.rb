# frozen_string_literal: true
require 'date'

class ApplicationController < ActionController::Base
  helper_method :current_day
  helper_method :meal_id_to_name
  helper_method :student_id_to_name
  helper_method :time_convert
  helper_method :weekday_to_string
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    current_admin || current_student

  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Student)
      navigation_studentnavigation_path

    elsif resource.is_a?(Admin)
      navigation_adminnavigation_path
    end

  end
  def after_sign_up_path_for(resoruce)
    root_path
  end
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def current_day
    Time.new.wday
  end

  def meal_id_to_name(id)
    Meal.find(id).meal_name
  end

  def student_id_to_name(id)
    Student.find(id).student_username
  end

  def time_convert(time)
    central_time = time.in_time_zone('Central Time (US & Canada)')
    central_time.strftime('%Y %m-%d %I:%M %p')
  end

  def weekday_to_string(weekday)
    # weekdays = { 0 => :sunday, 1 => :monday, 2 => :tuesday, 3 => :wednesday, 4 => :thursday, 5 => :friday, 6 => :saturday}
    case weekday
    when 0
      return 'Sunday'
    when 1
      return 'Monday'
    when 2
      return 'Tuesday'
    when 3
      return 'Wednesday'
    when 4
      return 'Thursday'
    when 5
      return 'Friday'
    when 6
      return 'Saturday'
    else
      return 'Error- not a valid day of the week'
    end

  end
end
