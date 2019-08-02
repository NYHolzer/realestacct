class Building < ApplicationRecord
    has_many :units
    has_many :users, through: :units
    has_many :revenues, through: :units
    has_many :expenses, through: :units


    validates :name, presence: true
    validates :name, uniqueness: true, on: :update
    validates :city, format: {with: /\A[a-zA-Z\s]*\z/, message: "must only contain letters"}, on: :update
    validates :state, length: {is: 2}, on: :update
    validates :zip_code, numericality: true, on: :update
    validates :zip_code, length: {is: 5}, on: :update

end
