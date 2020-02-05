require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'find meal id name' do
    it 'should return the name of the meal' do
      meal = Meal.create!({ meal_name: "Sushi", meal_calories: 600, monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, saturday: true, sunday: false, description: 'sushi sushi sushi', dietary_restrictions: "{:VGN=>false, :VGT=>false, :GF=>true, :NF=>false, :DF=>true}" })
      id = meal.id
      expect(controller.meal_id_to_name(id)).to eq("Sushi")
    end
  end
  describe 'find student name from id' do
    it 'should return the student username' do
      student = Student.create!( { student_first_name: "Hermione", student_last_name: "Granger", student_username: "HGranger", password: "abracadabra", password_confirmation: "abracadabra", email: "hgranger@test.com", student_phonenumber: "515-720-8537", dietary_restrictions: "{:VGN=>true, :VGT=>true, :GF=>false, :NF=>false, :DF=>true}" })
      id = student.id
      expect(controller.student_id_to_name(id)).to eq("HGranger")
    end
  end
  describe 'testing current day' do
    it 'should return error out' do
      expect(controller.weekday_to_string(99)).to eq('Error- not a valid day of the week')
    end
    it 'should return the current days' do
      expect(controller.weekday_to_string(0)).to eq('Sunday')
      expect(controller.weekday_to_string(1)).to eq('Monday')
      expect(controller.weekday_to_string(2)).to eq('Tuesday')
      expect(controller.weekday_to_string(3)).to eq('Wednesday')
      expect(controller.weekday_to_string(4)).to eq('Thursday')
      expect(controller.weekday_to_string(5)).to eq('Friday')
      expect(controller.weekday_to_string(6)).to eq('Saturday')
    end
  end
end
