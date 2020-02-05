class Meal < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  validates_presence_of :meal_name
  validates_presence_of :meal_calories
  validates_presence_of :description
  def self.all_days
    %w[monday tuesday wednesday thursday friday saturday sunday]
  end

  def self.all_restrictions
    %w[VGN VGT GF NF DF]
  end

  def self.get_restriction_string(res)
    if res == :VGN
      'VGN'
    elsif res == :VGT
      'VGT'
    elsif res == :GF
      'GF'
    elsif res == :NF
      'NF'
    elsif res == :DF
      'DF'
    end
  end
end
