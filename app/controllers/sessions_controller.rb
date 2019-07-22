class SessionsController < ApplicationController
    def new
        @user = User.new
        render :login
    end 

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            log_in(@user) 
            redirect_to user_path(current_user)
        else 
            flash[:error] = "Sorry, your username or password is incorrect"
            redirect_to '/login'
        end
    end 

    #omniauth login facebook
    def fbcreate
        @user = User.find_or_create_by(uid: fb_auth['uid']) do |u|
            u.username = fb_auth['info']['name']
            u.email = fb_auth['info']['email']
            u.image = fb_auth['info']['image']
            u.password = fb_auth['uid'] #Secure Random Hex
        end

        session[:user_id] = @user.id
       
        redirect_to user_path(@user)
    end

    def home 
    end

    #logout
    def destroy
        session.clear
        redirect_to '/'
    end

    def fb_auth
        request.env['omniauth.auth']
    end

    def googleAuth
        #Get access tokens from the google server
        access_token = request.env["omniauth.auth"]
        @user = User.from_omniauth(access_token)
        log_in(@user)
        # Access_token is used to authenticate request made from the rails application to the google server
        @user.google_token = access_token.credentials.token
        # Refresh_token to request new access_token
        # Note: Refresh_token is only sent once during the first request
        refresh_token = access_token.credentials.refresh_token
        @user.google_refresh_token = refresh_token if refresh_token.present?
        @user.save
        redirect_to user_path(current_user)
    end


end