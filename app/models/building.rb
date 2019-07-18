class Building < ApplicationRecord
    has_many :units
    has_many :users, through: :units

    validates :name, :address1, :city, :state, :zip_code, presence: true
    validates :name, uniqueness: true
    validates :city, format: {with: /\A[a-zA-Z\s]*\z/, message: "must only contain letters"}
    validates :state, length: {is: 2}
    validates :zip_code, lenth: {is: 5}
end