note
	description: "[
	Object representing the vertical alignment of text in a cell. 
	
	VERTICAL_ALIGN_UNSPECIFIED 	The vertical alignment is not specified. Do not use this.
	TOP 	The text is explicitly aligned to the top of the cell.
	MIDDLE 	The text is explicitly aligned to the middle of the cell.
	BOTTOM 	The text is explicitly aligned to the bottom of the cell.

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Vertical Align", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#verticalalign", "protocol=uri"

class
	EG_VERTICAL_ALIGN

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
			set_value (vertical_align_unspecified)
		end

	vertical_align_unspecified: INTEGER = 1
			-- The vertical alignment is not specified. Do not use this.

	top: INTEGER = 2
			-- The text is explicitly aligned to the top of the cell.

	middle: INTEGER = 3
			-- The text is explicitly aligned to the middle of the cell.

	bottom: INTEGER = 4
			--The text is explicitly aligned to the bottom of the cell.

feature -- Change Elements

	set_top
		do
			set_value (top)
		ensure
			value_set_with_top: value = top
		end

	set_middle
		do
			set_value (middle)
		ensure
			value_set_with_middle: value = middle
		end

	set_bottom
		do
			set_value (bottom)
		ensure
			value_set_with_bottom: value = bottom
		end

feature -- Status Report

	is_top: BOOLEAN
		do
			Result := value = top
		end

	is_middle: BOOLEAN
		do
			Result := value = middle
		end

	is_bottom: BOOLEAN
		do
			Result := value = bottom
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = vertical_align_unspecified or else
			          a_value = top or else
			          a_value = middle or else
			          a_value = bottom
		end

end
