note
	description: "[
		Object representing the amount of padding around the cell, in pixels. When updating padding, every field must be specified. 
		
		{
		  "top": integer,
		  "right": integer,
		  "bottom": integer,
		  "left": integer
		}
	
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_PADDING

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			top := 2
 	        right := 3
        	bottom := 2
        	left := 3
		end

feature -- Access

	top: INTEGER
			-- The top padding of the cell.

	right: INTEGER
			-- The right padding of the cell.

	bottom: INTEGER
			-- The bottom padding of the cell.

	left: INTEGER
			-- The left padding of the cell.


feature -- Change Element

	set_top (a_top: like top)
		do
			top := a_top
		end

	set_right (a_right: like right)
		do
			right := a_right
		end

	set_bottom (a_bottom: like bottom)
		do
			bottom := a_bottom
		end

	set_left (a_left: like left)
		do
			left := a_left
		end

end
