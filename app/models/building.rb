class Building < ApplicationRecord
    has_many :units
    has_many :users, through: :units

    validates :name, presence: true
    validates :name, uniqueness: true
    validates :city, format: {with: /\A[a-zA-Z\s]*\z/, message: "must only contain letters"}
    validates :state, length: {is: 2}
    validates :zip_code, numericality: true
    validates :zip_code, length: {is: 5}
end
