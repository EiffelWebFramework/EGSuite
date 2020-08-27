note
	description: "[
	The direction of text in a cell. 
	
	Enums
	TEXT_DIRECTION_UNSPECIFIED 	The text direction is not specified. Do not use this.
	LEFT_TO_RIGHT 				The text direction of left-to-right was set by the user.
	RIGHT_TO_LEFT 				The text direction of right-to-left was set by the user. 

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=TextDirection", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#TextDirection", "protocol=uri"

class
	EG_TEXT_DIRECTION

inherit

	EG_ENUM
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			set_value (text_direction_unspecified)
		end

	text_direction_unspecified: INTEGER = 1
			-- The text direction is not specified. Do not use this.

	left_to_right: INTEGER = 2
			-- The text direction of left-to-right was set by the user.

	right_to_left: INTEGER = 3
			-- The text direction of right-to-left was set by the user.

feature -- Change Elements

	set_left_to_right
		do
			set_value (left_to_right)
		ensure
			value_set_with_left_to_right: value = left_to_right
		end

	set_right_to_left
		do
			set_value (right_to_left)
		ensure
			value_set_with_right_to_left: value = right_to_left
		end

feature -- Status Report

	is_left_to_right: BOOLEAN
		do
			Result := value = left_to_right
		end

	is_right_to_left: BOOLEAN
		do
			Result := value = right_to_left
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = text_direction_unspecified or else
			          a_value = left_to_right or else
			          a_value = right_to_left
		end


feature -- Eiffel to JSON

	to_json: JSON_STRING
		do
			if is_left_to_right  then
				Result := "LEFT_TO_RIGHT"
			elseif is_right_to_left then
				Result := "RIGHT_TO_LEFT"
			else
				Result := "TEXT_DIRECTION_UNSPECIFIED"
			end
		end

end
