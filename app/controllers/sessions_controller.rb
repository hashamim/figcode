class SessionsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        @user = User.find_by(username: user_params[:username]);
        if !@user
            render json: {errors: "no user with that username"}, status: 422;
        elsif @user.password == user_params[:password]
            session[:session_token] = @user.session_token
            redirect_to new_message_url
        else
            render json: {errors: "incorrect password"}, status: 422
        end
    end

    def new
        if(User.find_by(session_token: session[:session_token]))
            redirect_to new_message_url
        else
            render :new
        end
    end

    def destroy
        @user = User.find_by(session_token: session[:session_token])
        @user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_user_url
    end

    private
    def user_params
        params.require(:user).permit(:username,:password,:address)
    end
end