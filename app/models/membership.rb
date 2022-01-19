class Membership
  include Mongoid::Document
  belongs_to :virtual_room
  belongs_to :student  

  field :vr_code
end
