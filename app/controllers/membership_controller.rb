class MembershipController < ApplicationController
	def index
	    @memberships = if params[:coach_id].present?
	      	VirtualRoom.find_by_coach(params[:coach_id])
	    else
	      	Membership.all
	    end
	    
	    if params[:student_username].present?     
	     	uname = params[:student_username]
			student_ids = Student.where(username: /.*(#{Regexp.escape(uname)}).*/i).pluck(:id)
			@memberships = VirtualRoom.plus_student(student_ids)
	    end

	    render json: {
	    	membership: @memberships
	    }
	end	
end
