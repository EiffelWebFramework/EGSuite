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


feature -- Access

	color_type: detachable EG_THEME_COLOR
			-- The type of the spreadsheet theme color.


	color: detachable EG_COLOR_STYLE
			-- the concrete color corresponding to the theme color type.

feature -- Element Change

	set_color_type (a_type: like color_type)
			-- Set `color_type` with `a_type`
		do
			color_type := a_type
		ensure
			color_type_set: color_type = a_type
		end

	set_color (a_color: like color)
			-- Set `color` with `a_color`
		do
			color := a_color
		ensure
			color_set: color = a_color
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			if attached color_type as l_type then
				Result.put (l_type.to_json, "colorType")
			end
			if attached color as l_color then
				Result.put (l_color.to_json, "color")
			end

		end
end
