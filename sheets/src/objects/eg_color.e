note
	description: "Summary description for {EG_COLOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_COLOR

inherit

	ANY
		redefine
			default_create
		end
create
	default_create

feature {NONE} -- Access

	default_create
		do
			red := 0.0
			green := 0.0
			blue := 0.0
			alpha := 0.0
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


feature -- Change Element

	set_red (a_val: REAL)
		do
			red := a_val
		ensure
			red_set: red = a_val
		end

	set_green (a_val: REAL)
		do
			green := a_val
		ensure
			green_set: green = a_val
		end

	set_blue (a_val: REAL)
		do
			blue := a_val
		ensure
			blue_set: blue = a_val
		end

	set_alpha (a_val: REAL)
		do
			alpha := a_val
		ensure
			alpha_set: alpha = a_val
		end


invariant
	red_invariant: red >= 0.0 and then red <= 1.0
	green_invariant: green >= 0.0 and then green <= 1.0
	blue_invariant: blue >= 0.0 and then blue <= 1.0
	alpha_invariant: alpha >= 0.0 and then alpha <= 1.0
end
