I decided to use an aggregate function to search membership by specific coach and student. In filtering by the coach, we must convert params[:coach_id], which belongs to the String class, to ObjectId so that it can be used in the $match key.
For filtering by student_username, we must use 'Regexp.escape' so that params[:student_username] can be used for the 'username' key belonging to the Student collection.

class MembershipController < ApplicationController
	def index
	    @memberships = if params[:coach_id].present?
	      	VirtualRoom.find_by_coach(params[:coach_id])
	    else
	      	Membership.all
	    end
	    
	    if params[:student_username].present?     
	     	uname = Regexp.escape(params[:student_username])
			student_ids = Student.where(username: /.*(#{uname}).*/i).pluck(:id)
			@memberships = VirtualRoom.plus_student(student_ids)
	    end

	end	
end

class Coach
  include Mongoid::Document
  has_many :virtual_rooms
  field :name  
end

class Membership
  include Mongoid::Document
  belongs_to :virtual_room
  belongs_to :student  

  field :vr_code
end

class Student
  include Mongoid::Document
  has_many :memberships
    
  field :username

end

class VirtualRoom
  include Mongoid::Document
  belongs_to :coach
  has_many :memberships

  field :code

  def self.look_up_membership
      {
          '$lookup' => { 
              'from' => 'memberships',
              'localField'=> "code", 
              'foreignField'=> "vr_code", 
              as: "memberships"
          }
      }
  end

  def self.find_by_coach(coach_id)
    collection.aggregate([
        look_up_membership,
        {
          '$match' => {
              'coach_id' => BSON::ObjectId(coach_id)
          }
        }
        
    ])
  end 


  def self.plus_student(student_ids)
    collection.aggregate([
      look_up_membership,
      { '$unwind'=> "$memberships" },
      {
        '$match' => {
            'memberships.student_id'=> {
              '$in'=> student_ids
            }
        }
      }
    ])
  end

end
