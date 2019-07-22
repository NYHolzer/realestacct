class Unit < ApplicationRecord
    belongs_to :user
    belongs_to :building
    has_many :revenues
    has_many :expenses

    validates :apt_num, :building_name, presence: true

    def building_name=(name)
        self.building = Building.find_or_create_by(name: name)
    end

    def building_name
        self.building ? self.building.name : nil
    end 

    def building_state
        self.building.state
    end
end
