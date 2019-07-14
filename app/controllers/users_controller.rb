class UsersController < ApplicationController
    
    #loading signup form
    def new
        @user = User.new
    end

    #signup
    def create
        @user = User.new(user_params)
        if @user.save 
            #login the user
            session[:user_id] = @user_id
            redirect_to users_path(@user_id)
        else
            render :new 
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
