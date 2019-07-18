class Building < ApplicationRecord
    has_many :units
    has_many :users, through: :units

    validates :
end
