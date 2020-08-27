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
			create font_family.make_empty
			font_size := 0
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


feature -- Change Element

	set_foreground_color (a_color: EG_COLOR)
			-- Set `foreground_color` with `a_color`.
		do
			foreground_color := a_color
		ensure
			foreground_color_set: foreground_color = a_color
		end

	set_foreground_color_style (a_color: EG_COLOR_STYLE)
			-- Set `foreground_color_style` with `a_color`.
		do
			foreground_color_style := a_color
		ensure
			foreground_color_style_set: foreground_color_style = a_color
		end

	set_font_family (a_font: STRING)
			-- Set `font_family` with `font`.
			--| how do we know if a font is valid?
		do
			font_family := a_font
		ensure
			font_family_set: font_family = a_font
		end

	set_font_size (a_size: INTEGER)
			-- Set `font_size` with `a_size`.
		require
			valid_size: a_size > 0
		do
			font_size := a_size
		ensure
			font_size_set: font_size = a_size
		end

	set_bold (a_bold: BOOLEAN)
			-- Set `bold` with `a_bold`.
		do
			bold := a_bold
		ensure
			bold_set: bold = a_bold
		end

	set_italic (a_italic: BOOLEAN)
			-- Set `italic` with `a_italic`.
		do
			italic := a_italic
		ensure
			italic_set: italic = a_italic
		end

	set_strikethrough (a_strikethrough: BOOLEAN)
			-- Set `strikethrough` with `a_strikethrough`.
		do
			strikethrough := a_strikethrough
		ensure
			strikethrough_set: strikethrough = a_strikethrough
		end

	set_underline (a_underline: BOOLEAN)
			-- Set `underline` with `a_underline`.
		do
			underline := a_underline
		ensure
			underline_set: underline = a_underline
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- JSON representation of current object
			--		{
			--		  "foregroundColor": {
			--		    object (Color)
			--		  },
			--		  "foregroundColorStyle": {
			--		    object (ColorStyle)
			--		  },
			--		  "fontFamily": string,
			--		  "fontSize": integer,
			--		  "bold": boolean,
			--		  "italic": boolean,
			--		  "strikethrough": boolean,
			--		  "underline": boolean
			--		}

		do
			create Result.make_empty
			if attached foreground_color as l_color then
				Result.put (l_color.to_json, "foregroundColor")
			end
			if attached foreground_color_style as l_fg_color then
				Result.put (l_fg_color.to_json, "foregroundColorStyle")
			end
			if attached font_family as l_font_family then
				Result.put (create {JSON_STRING}.make_from_string (l_font_family), "fontFamily")
			end
			Result.put (create {JSON_NUMBER}.make_integer (font_size),"fontSize")
			Result.put (create {JSON_BOOLEAN}.make (bold),"bold")
			Result.put (create {JSON_BOOLEAN}.make (italic),"italic")
			Result.put (create {JSON_BOOLEAN}.make (strikethrough),"strikethrough")
			Result.put (create {JSON_BOOLEAN}.make (underline),"underline")
		end
end
