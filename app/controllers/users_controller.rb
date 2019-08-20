class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        @user = User.new(user_params)
        if @user.save
            session[:session_token] = @user.session_token
            redirect_to new_message_url
        else
            render json: {errors: @user.errors.full_messages}, status: 422
        end
    end
    def new
        if(User.find_by(session_token: session[:session_token]))
            redirect_to new_message_url
        else
            render :new
        end
    end
    private
    def user_params
        params.require(:user).permit(:username,:password,:address)
    end
end