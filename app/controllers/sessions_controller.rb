class SessionsController < ApplicationController
    def new
        @user = User.new
        render :login
    end 

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user_id 
            redirect_to user_path(@user)
        else 
            render :login
        end
    end 

    def home 
    end

    #logout
    def destroy
        session.clear
        redirect_to '/'
    end
end