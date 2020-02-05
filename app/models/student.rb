class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attr_accessor :VGN
  attr_accessor :VGT
  attr_accessor :DF
  attr_accessor :NF
  attr_accessor :GF
  validates_presence_of :student_username
  validates_presence_of :email
  VALID_PHONE_REGEX = /[0-9]{3}-[0-9]{3}-[0-9]{4}/
  validates :student_phonenumber, presence: true, format: {with: VALID_PHONE_REGEX, message: " must be in xxx-xxx-xxxx format."}
  validates_presence_of :student_first_name
  validates_presence_of :student_last_name
  has_many :orders, dependent: :destroy
end

