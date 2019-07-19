class UnitsController < ApplicationController
    def index 
    end
    
    def show
    end

    def new 
        @unit = Unit.new
    end

    def create
        @unit = Unit.new(unit_params)
        if @unit.save
            redirect_to building_path(@unit.building.id)
        else 
            render :new
        end
    end

    def edit
    end

    def update
    end

    private
    def unit_params
        params.require(:unit).permit(:apt_num, :tenant, :unit_id)
    end
end
