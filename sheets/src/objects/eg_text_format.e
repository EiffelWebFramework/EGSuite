note
	description: "[
	Object representing The format of a run of text in a cell. Absent values indicate that the field isn't specified. 
		{
		  "foregroundColor": {
		    object (Color)
		  },
		  "foregroundColorStyle": {
		    object (ColorStyle)
		  },
		  "fontFamily": string,
		  "fontSize": integer,
		  "bold": boolean,
		  "italic": boolean,
		  "strikethrough": boolean,
		  "underline": boolean
		}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Text format", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#TextFormat", "protocol=uri"

class
	EG_TEXT_FORMAT

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
			create foreground_color
			create foreground_color_style
			create font_family.make_from_string ("arial,sans,sans-serif")
		end

feature -- Access

	foreground_color: EG_COLOR
			-- The foreground color of the text.

	foreground_color_style: EG_COLOR_STYLE
			-- The foreground color of the text. If foregroundColor is also set, this field takes precedence.

	font_family: STRING
			-- The font family.

	font_size: INTEGER
			-- The size of the font.

	bold: BOOLEAN
			-- 	True if the text is bold.

	italic: BOOLEAN
			-- True if the text is italicized.

	strikethrough: BOOLEAN
			-- True if the text has a strikethrough.

	underline: BOOLEAN
			-- True if the text is underlined.

end
