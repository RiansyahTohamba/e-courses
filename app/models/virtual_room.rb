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
