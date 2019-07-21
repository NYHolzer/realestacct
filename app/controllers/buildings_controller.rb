class BuildingsController < ApplicationController
    def index 
        @buildings = Building.all.find_by(user_id: current_user.id)
    end
    def show
        @building = Building.find_by(id: params[:id])
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
        @building = Building.find_by(params[:id])
    end

    def update
    end

    private
    def building_params
        params.require(:building).permit(:name, :address1, :address2, :city, :state, :zip_code)
    end
end
