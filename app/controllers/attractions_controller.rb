class AttractionsController < ApplicationController

    before_action :set_attraction, only: [:show, :ride, :edit, :update]

    def index
        @attractions = Attraction.all
    end

    def new
        @attraction = Attraction.new
    end

    def create
        if current_user && current_user.admin
            @attraction = Attraction.new(attraction_params)
            if @attraction.save
                redirect_to attraction_path(@attraction)
            else
                render "new"
            end
        else
            flash[:error] = "You must be an admin"
            redirect_to root_path
        end
    end

    def update
        if current_user && current_user.admin
            if @attraction.update(attraction_params)
                redirect_to attraction_path(@attraction)
            else
                render "edit"
            end
        else
            flash[:error] = "You must be an admin"
            redirect_to root_path
        end
    end

    def ride
        if current_user
            errors = Ride.new(attraction: @attraction, user: current_user).take_ride
            if errors
                flash[:error] = errors
            else
                flash[:message] = "Thanks for riding the #{@attraction.name}!"
            end
            redirect_to user_path(current_user)
        else
            flash[:error] = "You must be signed in to go on a ride"
            redirect_to root_path
        end
    end

    private
    def set_attraction
        @attraction = Attraction.find_by(id: params[:id])
    end

    def attraction_params
        params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
    end

end
