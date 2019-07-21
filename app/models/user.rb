class User < ApplicationRecord
    has_secure_password #password validations
    
    has_many :units
    has_many :buildings, through: :units

    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true
    
    def uniq_buildings 
        self.buildings.uniq
    end

    def self.from_omniauth(auth)
        # Creates a new user only if it doesn't exist
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
        end
    end
end
