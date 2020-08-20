note
	description: "[
	A border along a cell. 
	
	JSON representation

	{
	  "style": enum (Style),
	  "width": integer,
	  "color": {
	    object (Color)
	  },
	  "colorStyle": {
	    object (ColorStyle)
	  }
	}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=border", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#border", "protocol=uri"

class
	EG_BORDER

feature -- Access

	style: detachable EG_STYLE
		-- The style of the border.

	color: detachable EG_COLOR
		-- The color of the border.

	color_style: detachable EG_COLOR_STYLE
		-- The color of the border. If color is also set, this field takes precedence. 	

feature -- Element Change

	set_style (a_style: like style)
		do
			style := a_style
		end

	set_color (a_color: like color)
		do
			color := a_color
		end

	set_color_style (a_color_style: like color_style)
		do
			color_style := a_color_style
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make
			-- TODO
		end
end
