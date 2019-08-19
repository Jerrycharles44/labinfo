class User < ActiveRecord::Base
    has_secure_password
    has_many :workshops
    has_many :userWorkshops
    validates :full_name, :username, :email, presence: true
  end