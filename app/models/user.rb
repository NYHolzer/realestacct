class User < ApplicationRecord
    has_secure_password #password validations
    
    has_many :units
    has_many :buildings, through: :units

    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true


end
