class User < ActiveRecord::Base
  # write associations here
  has_secure_password

  has_many :rides
  has_many :attractions, through: :rides

  def mood
      return "?" if nausea==nil || happiness==nil
      return "sad" if nausea >= happiness
      return "happy" if nausea < happiness
  end
end
