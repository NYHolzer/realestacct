class RevenuesController < ApplicationController
    def new
        if params[:unit_id] && !Unit.exists?(params[:unit_id])
            flash[:alert] = "Unit not found!"
            redirect_to buildings_path
        else 
            @revenue = Revenue.new(unit_id: params[:unit_id])
        end
    end

    def create
        @revenue = Revenue.new(revenue_params)
        if @revenue.save
            redirect_to unit_path(@revenue.unit)
        else 
            render :new
        end
    end

    private 
    def revenue_params
        params.require(:revenue).permit(:rev_type, :amount, :date, :unit_id)
    end
end
