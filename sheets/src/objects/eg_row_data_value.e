note
	description: "Summary description for {EG_ROW_DATA_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ROW_DATA_VALUE


create
	make_from_effective_value


feature {NONE} -- Initialization

	make_from_effective_value (v: like effective_value)
		do
			effective_value := v
		ensure
			effective_value = v
		end

feature -- Access

	formatted_value: detachable STRING

	effective_value: STRING

end
