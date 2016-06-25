class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end
  
  def self.sailors
  	includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorboat
  	includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).distinct
  end
  
  def self.talented_seamen
  	where("id IN (?)", self.sailors.pluck(:id) & self.motorboat.pluck(:id))

  	# includes(boats: :classifications).where("classifications.name = ? AND classifications.name = ?",values[0],values[1])
  end
  
  def self.non_sailors
  	where.not("id IN (?)", self.sailors.pluck(:id))
  end





end
