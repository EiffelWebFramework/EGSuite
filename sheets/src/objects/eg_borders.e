note
	description: "[
		Object rerpesenting the borders of the cell
	
	{
	  "top": {
	    object (Border)
	  },
	  "bottom": {
	    object (Border)
	  },
	  "left": {
	    object (Border)
	  },
	  "right": {
	    object (Border)
	  }
	}


	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=borders", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#Borders", "protocol=uri"

class
	EG_BORDERS

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
			create top
			create bottom
			create left
			create right
		end

feature -- Access

	top: EG_BORDER
			-- The top border of the cell.

	bottom: EG_BORDER
			-- The bottom border of the cell.

	left: EG_BORDER
			-- The left border of the cell.

	right: EG_BORDER
			-- The right border of the cell.

feature -- Element Change

	set_top (a_top: like top)
		do
			top := a_top
		end

	set_bottom (a_bottom: like bottom)
		do
			bottom := a_bottom
		end

	set_left (a_left: like left)
		do
			left := a_left
		end

	set_right (a_right: like right)
		do
			right := a_right
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
		end

end
