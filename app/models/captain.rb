class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
  	Captain.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Catamaran")
    #we need uniq captains because each captain has_many :boats and they might have the same classification
  end

  def self.sailors
  	  Captain.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Sailboat")
  end

    def self.motorboaters
  	  self.distinct("captains.id").joins(:classifications).where("classifications.name = ?","Motorboat")
  end

  def self.talented_seamen
     talented_ids= self.sailors & self.motorboaters
  	self.where("id in (?)", talented_ids)
  end

  def self.non_sailors
      sailors_ids= self.sailors.pluck(:id)
  	  self.where("id not in (?)", sailors_ids)
  end
end
