class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates_presence_of :admin_username
  validates_presence_of :email
  VALID_PHONE_REGEX = /[0-9]{3}-[0-9]{3}-[0-9]{4}/
  validates :admin_phonenumber, presence: true, format: {with: VALID_PHONE_REGEX, message: "must be in xxx-xxx-xxxx format."}
  validates_presence_of :admin_first_name
  validates_presence_of :admin_last_name
end
