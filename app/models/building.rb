class Building < ApplicationRecord
    has_many :units
    has_many :users, through: :units

    validates :name, :address1, :city, :state, :zip_code, presence: true
    validates :zip_code, numericality: true
end
