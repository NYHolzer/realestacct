class BuildingsController < ApplicationController
    def new 
        @building = Building.new
    end

    def create
        @building = Building.new
        if @building.save 
            redirect_to "/users/#{current_user.id}"
        else 
            render :new
        end
    end

    private
    def building_params
        params.require(:building).permit(:name, :address1, :address2, :city, :state, :zip_code)
    end
end
