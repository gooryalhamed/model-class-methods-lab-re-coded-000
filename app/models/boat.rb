class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	self.limit(5)   #take(3) will give an error
  end

  def self.dinghy
  	self.where("length < 20")
  end

    def self.ship
  	self.where("length >= 20")
  end

  def self.last_three_alphabetically
  	  self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
  	   self.where(captain_id: nil)
  end

  def self.sailboats
  	self.joins(:classifications).where("classifications.name = ?","Sailboat")
  end

  def self.with_three_classifications
  	self.joins(:classifications).group("boats.id").having("count(classifications.name) = 3")
  end

end
