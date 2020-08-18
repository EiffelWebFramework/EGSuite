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


end
