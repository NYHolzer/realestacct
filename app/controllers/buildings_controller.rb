class BuildingsController < ApplicationController
    def new 
        @building = Building.new
    end

    def create
        @building = Building.new(building_params)
        binding.pry
        if @building.save
            redirect_to user_path(current_user)
        else 
            render :new
        end
    end

    private
    def building_params
        params.require(:building).permit(:name, :address1, :address2, :city, :state, :zip_code)
    end
end
