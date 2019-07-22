class Revenue < ApplicationRecord
    belongs_to :unit

    scope :paid_between, lambda {|start_date, end_date| where("date BETWEEN ? AND ?", start_date, end_date )}

end
