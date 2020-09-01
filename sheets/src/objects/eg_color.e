note
	description: "[
	Color
		Represents a color in the RGBA color space.
		
	{
	  "red": number,
	  "green": number,
	  "blue": number,
	  "alpha": number
	}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Color", "ssrc=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#color", "protocol=uri"

class
	EG_COLOR

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
			is_default := True
		end

feature -- Access

	red: REAL
			-- The amount of red in the color as a value in the interval [0, 1].

	green: REAL
			-- The amount of green in the color as a value in the interval [0, 1].

	blue: REAL
			-- The amount of blue in the color as a value in the interval [0, 1].

	alpha: REAL
			-- The fraction of this color that should be applied to the pixel. That is, the final pixel color is defined by the equation:
			-- pixel color = alpha * (this color) + (1.0 - alpha) * (background color)
			-- This means that a value of 1.0 corresponds to a solid color, whereas a value of 0.0 corresponds to a completely transparent color.
			-- This uses a wrapper message rather than a simple float scalar so that it is possible to distinguish between a default value and the value being unset.
			-- If omitted, this color object is to be rendered as a solid color (as if the alpha value had been explicitly given with a value of 1.0). 		

	is_default: BOOLEAN
			-- Are the attributes in default values?


feature -- Element Change

	set_red (a_val: REAL)
			-- Set `red` to `a_val`.
		do
			is_default := False
			red := a_val
		ensure
			not_default: not is_default
			red_set: red = a_val
		end

	set_green (a_val: REAL)
		do
			is_default := False
			green := a_val
		ensure
			not_default: not is_default
			green_set: green = a_val
		end

	set_blue (a_val: REAL)
		do
			is_default := False
			blue := a_val
		ensure
			not_default: not is_default
			blue_set: blue = a_val
		end

	set_alpha (a_val: REAL)
		do
			is_default := False
			alpha := a_val
		ensure
			not_default: not is_default
			alpha_set: alpha = a_val
		end

	reset
			-- Reset the attributes to default values.
		do
			is_default := True
			red := 0
			green := 0
			blue := 0
			alpha := 0
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of current object.
		do
			if is_default then
				create Result.make
			else
				create Result.make_with_capacity (4)
				Result.put (create {JSON_NUMBER}.make_real (red), "red")
				Result.put (create {JSON_NUMBER}.make_real (green), "green")
				Result.put (create {JSON_NUMBER}.make_real (blue), "blue")
				Result.put (create {JSON_NUMBER}.make_real (alpha), "alpha")
			end
		end

invariant
	red_invariant: red >= 0.0 and then red <= 1.0
	green_invariant: green >= 0.0 and then green <= 1.0
	blue_invariant: blue >= 0.0 and then blue <= 1.0
	alpha_invariant: alpha >= 0.0 and then alpha <= 1.0
end
