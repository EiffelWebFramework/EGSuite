note
	description: "[
		The horizontal alignment of text in a cell.

		Enums
		HORIZONTAL_ALIGN_UNSPECIFIED	The horizontal alignment is not specified. Do not use this.
		LEFT							The text is explicitly aligned to the left of the cell.
		CENTER							The text is explicitly aligned to the center of the cell.
		RIGHT							The text is explicitly aligned to the right of the cell.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HorizontalAlign ", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#horizontalalign", "protocol=uri"

class
	EG_HORIZONTAL_ALIGN

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
			set_value (horizontal_align_unspecified)
		end

	horizontal_align_unspecified: INTEGER = 1
			-- The horizontal alignment is not specified. Do not use this.

	left: INTEGER = 2
			-- The text is explicitly aligned to the left of the cell.

	center: INTEGER = 3
			-- The text is explicitly aligned to the center of the cell.

	right: INTEGER = 4
			-- The text is explicitly aligned to the right of the cell.		

feature -- Change Elements

	set_left
		do
			set_value (left)
		ensure
			value_set_with_left: value = left
		end

	set_center
		do
			set_value (center)
		ensure
			value_set_with_center: value = center
		end

	set_right
		do
			set_value (right)
		ensure
			value_set_with_right: value = right
		end

feature -- Status Report

	is_left: BOOLEAN
		do
			Result := value = left
		end

	is_center: BOOLEAN
		do
			Result := value = center
		end

	is_right: BOOLEAN
		do
			Result := value = right
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = horizontal_align_unspecified or else
			          a_value = left or else
			          a_value = center or else
			          a_value = right
		end

feature -- Eiffel to JSON

	to_json: JSON_STRING
		do
			if is_left then
				Result := "LEFT"
			elseif is_center then
				Result := "CENTER"
			elseif is_right then
				Result := "RIGHT"
			else
				Result := "HORIZONTAL_ALIGN_UNSPECIFIED"
			end

		end


end
