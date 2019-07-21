class Revenue < ApplicationRecord
    belongs_to :unit

    def rev_type_list
        Revenue.select('DISTINCT type') 
    end
end
