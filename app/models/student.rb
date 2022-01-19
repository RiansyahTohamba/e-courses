class Student
  include Mongoid::Document
  has_many :memberships
    
  field :username

end
