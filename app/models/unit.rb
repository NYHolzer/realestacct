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

    def paid_between(start_date, end_date)
        self.revenues.paid_between(start_date, end_date)
    end

    def unit_revenues=(revenues)
        self.unit_revenues = revenues
    end
    def unit_revenues
        self.revenues
    end 
end
