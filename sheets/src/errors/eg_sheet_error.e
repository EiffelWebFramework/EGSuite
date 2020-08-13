note
	description: "Summary description for {EG_SHEET_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SHEET_ERROR

create
	make,
	make_from_separate

feature {NONE} -- Initialize

	make (a_msg: like message)
		do
			message := a_msg
		ensure
			message = a_msg
		end

	make_from_separate (other: separate like Current)
		do
			create message.make_from_separate (other.message)
		end

feature -- Access

	message: STRING

feature -- SCOOP

	error_from_separate (an_err: separate like Current): EG_SHEET_ERROR
		do
			create Result.make_from_separate (an_err)
		ensure
			instance_free: Class
		end

end
