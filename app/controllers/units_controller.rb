class UnitsController < ApplicationController
    before_action :require_login
    
    def index 
        @tenants = Unit.ten_alpha
        @units = current_user.units
        respond_to do |format|
            format.html {@tenants}
            format.json {render json: @units, status: 200 }
        end
    end
    
    def show
        if params[:start_date] && params[:end_date]
            set_unit
            @units = @unit.paid_between(params[:start_date], params[:end_date])
        elsif params[:building_id]
            @unit = Building.find(params[:building_id]).units.find(params[:id])
            @units = @unit.revenues
        else
            set_unit
            @units = @unit.revenues
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
            respond_to do |format|
                format.html {redirect_to building_path(@unit.building)}
                format.json {render json: @units, status: 201 }
            end
        else 
            render :new
        end
    end

    def createJSON
        @unit = Unit.new(unit_params)
        @unit.user_id = current_user.id
        @unit.save
        redirect_to building_path(@unit.building_id)
    end 
    def edit
    end

    def update
    end

    def destroy
        set_unit
        @building = @unit.building
        @unit.destroy
        redirect_to building_path(@building)
    end

    private
    def unit_params
        params.require(:unit).permit(:apt_num, :tenant, :building_id, :building_name)
    end

    def set_unit
        @unit = Unit.find(params[:id])
    end
end
