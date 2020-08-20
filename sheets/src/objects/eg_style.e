note
	description: "[
		The style of a border. 
		
			Enums
			STYLE_UNSPECIFIED 	The style is not specified. Do not use this.
			DOTTED 				The border is dotted.
			DASHED 				The border is dashed.
			SOLID 				The border is a thin solid line.
			SOLID_MEDIUM 		The border is a medium solid line.
			SOLID_THICK 		The border is a thick solid line.
			NONE 				No border. Used only when updating a border in order to erase it.
			DOUBLE 				The border is two solid lines.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#style", "protocol=uri"

class
	EG_STYLE

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
			set_value (style_unspecified)
		end

	style_unspecified: INTEGER = 1
			--The style is not specified. Do not use this.

	dotted: INTEGER = 2
			-- The border is dotted.

	dashed: INTEGER = 3
			-- The border is dashed.

	solid: INTEGER = 4
			-- The border is a thin solid line.

	solid_medium: INTEGER = 5
			-- The border is a medium solid line.

	solid_thick: INTEGER = 6
			-- The border is a thick solid line.	

	none: INTEGER = 7
			-- No border. Used only when updating a border in order to erase it.

	double : INTEGER = 8
			-- The border is two solid lines.


feature -- Change Elements

	set_dotted
		do
			set_value (dotted)
		ensure
			value_set_with_dotted: value = dotted
		end

	set_dashed
		do
			set_value (dashed)
		ensure
			value_set_with_dashed: value = dashed
		end

	set_solid
		do
			set_value (solid)
		ensure
			value_set_with_solid: value = solid
		end

	set_solid_medium
		do
			set_value (solid_medium)
		ensure
			value_set_with_solid_medium: value = solid_medium
		end

	set_solid_thick
		do
			set_value (solid_thick)
		ensure
			value_set_with_solid_thick: value = solid_thick
		end

	set_none
		do
			set_value (none)
		ensure
			value_set_with_solid_none: value = none
		end

	set_double
		do
			set_value (double)
		ensure
			value_set_with_double: value = double
		end

feature -- Status Report

	is_dotted: BOOLEAN
		do
			Result := value = dotted
		end

	is_dashed: BOOLEAN
		do
			Result := value = dashed
		end

	is_solid: BOOLEAN
		do
			Result := value = solid
		end

	is_solid_medium: BOOLEAN
		do
			Result := value = solid_medium
		end

	is_solid_thick: BOOLEAN
		do
			Result := value = solid_thick
		end

	is_none: BOOLEAN
		do
			Result := value = none
		end

	is_double: BOOLEAN
		do
			Result := value = double
		end


	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = style_unspecified or else
			          a_value = dotted or else
			          a_value = dashed or else
			          a_value = solid or else
			          a_value = solid_medium or else
			          a_value = solid_thick or else
			          a_value = none or else
			          a_value = double
		end

feature -- Eiffel to JSON

	to_json: JSON_STRING
		do
			if is_dotted then
				Result := "DOTTED"
			elseif is_dashed then
				Result := "DASHED"
			elseif is_solid then
				Result := "SOLID"
			elseif is_solid_medium then
				Result := "SOLID_MEDIUM"
			elseif is_solid_thick then
				Result := "SOLID_THICK"
			elseif is_none then
				Result := "NONE"
			elseif is_double then
				Result := "DOUBLE"
			else
				Result := "STYLE_UNSPECIFIED"
			end
		end

end
