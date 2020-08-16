note
	description: "[
		Object representing a named range
	
	{
	  "namedRangeId": string,
	  "name": string,
	  "range": {
  	 	 object (GridRange)
 	   }	
	}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Named Range", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#namedrange", "protocol="

class
	EG_NAMED_RANGE

inherit

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create named_range_id.make_empty
			create name.make_empty
			create range
		end

feature -- Access

	named_range_id: STRING
			-- The ID of the named range.

	name: STRING
			-- The name of the named range.

	range: EG_GRID_RANGE
			-- The range this represents.

feature -- Change Element

	set_name_range (a_range_id: STRING)
		do
			named_range_id := a_range_id
		ensure
			named_range_id_set: named_range_id = a_range_id
		end

	set_name (a_name: STRING)
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_range (a_range: EG_GRID_RANGE)
		do
			range := a_range
		ensure
			range_set: range = a_range
		end
end
