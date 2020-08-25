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
	EIS: "name=Padding", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#padding", "protocol=uri"

class
	EG_PADDING

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
			-- Set `top` with `a_top`.
		do
			top := a_top
		ensure
			top_set: top = a_top
		end

	set_right (a_right: like right)
			-- Set `right` with `a_right`.
		do
			right := a_right
		ensure
			right_set: right = a_right
		end

	set_bottom (a_bottom: like bottom)
			-- Set `bottom` with `a_bottom`.
		do
			bottom := a_bottom
		ensure
			bottom_set: bottom = a_bottom
		end

	set_left (a_left: like left)
			-- Set `left`  with `a_left`.
		do
			left := a_left
		ensure
			left_set: left = a_left
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of current.
		do
			create Result.make_empty
			Result.put (create {JSON_NUMBER}.make_integer (top), "top")
			Result.put (create {JSON_NUMBER}.make_integer (right), "right")
			Result.put (create {JSON_NUMBER}.make_integer (bottom), "bottom")
			Result.put (create {JSON_NUMBER}.make_integer (left), "left")
		end
end
