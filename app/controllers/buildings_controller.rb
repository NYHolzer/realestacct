class BuildingsController < ApplicationController
    before_action :require_login
    
    def index
        @buildings = current_user.uniq_buildings
    end

    def show
        set_building
    end
    
    def new 
        @building = Building.new
    end

    def create
        @building = Building.new(building_params)
        if @building.save
            redirect_to user_path(current_user)
        else 
            render :new
        end
    end

    def edit
        set_building
    end

    def update
        set_building
        if @building.update(building_params)
            redirect_to user_path(current_user)
        else 
            render :edit
        end
    end

    private
    def building_params
        params.require(:building).permit(:name, :address1, :address2, :city, :state, :zip_code)
    end

    def set_building
        @building = Building.find(params[:id])
    end
end
