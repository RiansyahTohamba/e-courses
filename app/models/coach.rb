class Coach
  include Mongoid::Document
  has_many :virtual_rooms
  field :name  
end
