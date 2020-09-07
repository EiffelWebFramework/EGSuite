note
	description: "[
		The kind of sheet.
		
		Enums
		SHEET_TYPE_UNSPECIFIED	Default value, do not use.
		GRID					The sheet is a grid.
		OBJECT					The sheet has no grid and instead has an object like a chart or image.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Sheet Type", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#sheettype", "protocol=uri"

class
	EG_SHEET_TYPE

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
			set_value (sheet_type_unspecified)
		end

	sheet_type_unspecified: INTEGER = 1
			--Default value, do not use.

	grid: INTEGER = 2
			-- The sheet is a grid.

	object: INTEGER = 3
			-- The sheet has no grid and instead has an object like a chart or image.

feature -- Change Elements

	set_grid
		do
			set_value (grid)
		ensure
			value_set_with_grid: value = grid
		end

	set_object
		do
			set_value (object)
		ensure
			value_set_with_object: value = object
		end

feature -- Status Report

	is_grid: BOOLEAN
		do
			Result := value = grid
		end

	is_object: BOOLEAN
		do
			Result := value = object
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = sheet_type_unspecified or else
			          a_value = grid or else
			          a_value = object
		end


feature -- Eiffel to JSON

	to_json: JSON_STRING
			-- JSon representation of current object.
		do
			if is_grid then
				Result := "GRID"
			elseif is_object then
				Result := "OBJECT"
			else
				Result := "SHEET_TYPE_UNSPECIFIED"
			end
		end

end
