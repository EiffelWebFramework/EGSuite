note
	description: "[
	Whether to explicitly render a hyperlink. If not specified, the hyperlink is linked. 
	
	Enums
	HYPERLINK_DISPLAY_TYPE_UNSPECIFIED 	The default value: the hyperlink is rendered. Do not use this.
	LINKED 								A hyperlink should be explicitly rendered.
	PLAIN_TEXT 							A hyperlink should not be rendered. 		
	
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HyperlinkDisplayType", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#hyperlinkdisplaytype",  "protocol=uri"

class
	EG_HYPERLINK_DISPLAY_TYPE

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
			set_value (hyperlink_display_type_unspecified)
		end

	hyperlink_display_type_unspecified: INTEGER = 1
			-- The default value: the hyperlink is rendered. Do not use this.

	linked: INTEGER = 2
			-- A hyperlink should be explicitly rendered.

	plain_text: INTEGER = 3
			-- A hyperlink should not be rendered. 		

feature -- Change Elements

	set_linked
		do
			set_value (linked)
		ensure
			value_set_with_linked: value = linked
		end

	set_plain_text
		do
			set_value (plain_text)
		ensure
			value_set_with_plain_text: value = plain_text
		end

feature -- Status Report

	is_linked: BOOLEAN
		do
			Result := value = linked
		end

	is_plain_text: BOOLEAN
		do
			Result := value = plain_text
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = hyperlink_display_type_unspecified or else
			          a_value = linked or else
			          a_value = plain_text
		end

feature -- Eiffel to JSON

	to_json: JSON_STRING
		do
			if is_linked then
				Result := "LINKED"
			elseif is_plain_text then
				Result := "PLAIN_TEXT"
			else
				Result := "HYPERLINK_DISPLAY_TYPE_UNSPECIFIED"
			end
		end

end
