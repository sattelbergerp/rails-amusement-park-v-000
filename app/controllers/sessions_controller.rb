class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(name: params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else

            @error = "Invalid username or password."
            render "new"
        end
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

end
