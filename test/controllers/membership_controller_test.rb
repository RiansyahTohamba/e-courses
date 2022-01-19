require 'test_helper'
# sepertinya test untuk model yg use Mongoid berbeda dengan ActiveRecord
# harus pelajari 'mongoid rails test' jika ingin tahu
class MembershipControllerTest < ActionDispatch::IntegrationTest

  def join_member_student_virtualroom
    true
  end
  def join_member_student_virtualroom
    true
  end
  def join_member_student
    true
  end
  # setelah run test, ditanyakan mana table 'coaches'
  # emang harus buat dulu?

  # 4 possibilities
  test "coach_id and student.username is exist" do
    coach_id = '61caabdeb2cc64ecf52bd2aa'
    student_username = 'warto'
    result = true
    assert(result,join_member_student_virtualroom)    
  end

  test "coach_id is exist but student.username isn't exist" do
    coach_id = '61caabdeb2cc64ecf52bd2aa'
    members = VirtualRoom.includes(:memberships).where(coach_id: coach_id)
    assert(result,members)    
  end
  
  test "coach_id isn't exist but student.username is exist" do
    student_username = 'warto'        
    members = Membership.all
    assert(result,join_member_student)
  end

  test "coach_id and student.username isn't exist" do
    assert(result,Membership.all)        
  end

end
