class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :user
  belongs_to :attraction

  def take_ride
      ride_errors = []
      ride_errors << "You do not have enough tickets to ride the #{attraction.name}." if user.tickets < attraction.tickets
      ride_errors << "You are not tall enough to ride the #{attraction.name}." if user.height < attraction.min_height
      if ride_errors.count == 0
          user.tickets -= attraction.tickets
          user.nausea += attraction.nausea_rating
          user.happiness += attraction.happiness_rating
          user.save
          return nil
      else
          return "Sorry. #{ride_errors.join(" ")}"
      end
  end
end
