# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def virtual_rooms
	shin = Coach.new(name: 'Shin Tae Yong', code: 'co1')
	shin.save

	# data STY

	park = Coach.new(name: 'Park Ji Sung', code: 'co2')
	park.save

	vrbeam = VirtualRoom.new(coach: shin)
	vrbeam.save

	vrmath = VirtualRoom.new(coach: park)
	vrmath.save

	vrfisi = VirtualRoom.new(coach: shin)
	vrfisi.save

	st1 = Student.new(username: 'Warto',code: 'st1')
	st1.save
	
	st3 = Student.new(username: 'suwarto',code: 'st3')
	st3.save
	
	st2 = Student.new(username: 'Nani wijaya',code: 'st2')
	st2.save
	
	Membership.create([
		{ virtual_room: vrbeam, student:st1, student_code: st1.code },
		{ virtual_room: vrfisi, student:st1, student_code: st1.code },
		{ virtual_room: vrmath, student:st1, student_code: st1.code },
		{ virtual_room: vrmath, student:st2, student_code: st2.code },
		{ virtual_room: vrfisi, student:st3, student_code: st3.code },
	])		
end
# coach_id = 61caabdeb2cc64ecf52bd2aa  
virtual_rooms

p 'sukses!'