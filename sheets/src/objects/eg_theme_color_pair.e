note
	description: "[
		Object representing a pair mapping a spreadsheet theme color type to the concrete color it represents.
			
		{
		  "colorType": enum (ThemeColorType),
		  "color": {
		    object (ColorStyle)
		  }
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Theme color pair", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#themecolorpair", "protocol=uri"

class
	EG_THEME_COLOR_PAIR

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
			create color_type
			create color
		end

feature -- Access

	color_type: EG_THEME_COLOR
			-- The type of the spreadsheet theme color.


	color: EG_COLOR_STYLE
			-- the concrete color corresponding to the theme color type.

feature -- Element Change

	set_color_type (a_type: like color_type)
		do
			color_type := a_type
		end

	set_color (a_color: like color)
		do
			color := color
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			Result.put (color_type.to_json, "colorType")
		end
end
