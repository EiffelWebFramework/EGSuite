note
	description: "Summary description for {EG_ROW_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ROW_DATA

create
	make

feature {NONE} -- Initialization

	make (n: like values.count)
		do
			create values.make (n)
		end

feature -- Access

	values: ARRAYED_LIST[EG_ROW_DATA_VALUE]

end
