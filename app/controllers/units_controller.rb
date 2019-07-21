class UnitsController < ApplicationController
    before_action :require_login
    
    def index 
    end
    
    def show
        if params[:building_id]
            @unit = Building.find(params[:building_id]).units.find(params[:id])
        else 
            @unit = Unit.find(params[:id])
        end
    end

    def new 
        # See if params[:building_id] is present and check if the author is real
        if params[:building_id] && !Building.exists?(params[:building_id])
            flash[:alert] = "Building not found!"
            redirect_to buildings_path
        else 
            @unit = Unit.new(building_id: params[:building_id])
        end
    end

    def create
        @unit = Unit.new(unit_params)
        @unit.user_id = current_user.id
        if @unit.save && @unit.building_state.blank?
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
