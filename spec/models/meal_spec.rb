require 'rails_helper'
require 'spec_helper'
RSpec.describe Meal, type: :model do
  describe 'calls meal functions' do
    it 'should return the days of the week' do
      expect(Meal.all_days).to eq(%w[monday tuesday wednesday thursday friday saturday sunday])
    end
    it 'should return the string for restrictions' do
      expect(Meal.get_restriction_string(:VGN)).to eq("VGN")
      expect(Meal.get_restriction_string(:VGT)).to eq("VGT")
      expect(Meal.get_restriction_string(:DF)).to eq("DF")
      expect(Meal.get_restriction_string(:NF)).to eq("NF")
      expect(Meal.get_restriction_string(:GF)).to eq("GF")



    end
  end
end
