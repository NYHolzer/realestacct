class UnitsController < ApplicationController
    def index 
    end
    
    def show
    end

    def new 
        if params[:building_id] && !Building.exists?(params[:buidling_id])
            redirect_to buildings_path, alert: "Building not found!"
        else 
            @unit = Unit.new(building_id: params[:building_id])
        end
    end

    def create
        @unit = Unit.new(unit_params)
        @unit.user_id = current_user.id
        if @unit.save && @unit.building-_state.blank?
            redirect_to edit_building_path(@unit.building)
        elsif @unit.save
            redirect_to building_path(@unit.building)
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
        params.require(:unit).permit(:apt_num, :tenant, :building_id, :building_name)
    end
end
