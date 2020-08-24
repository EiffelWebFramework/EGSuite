note
	description: "[
		Object representing a Color value
	
		{

		  // Union field kind can be only one of the following:
		  "rgbColor": {
		    object (Color)
		  },
		  "themeColor": enum (ThemeColorType)
		  // End of list of possible types for union field kind.
		}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Color Style", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#ColorStyle", "protocol=uri"

class
	EG_COLOR_STYLE

feature -- Access

	rgb_color: detachable EG_COLOR
			-- RGB color.

	theme_color: detachable EG_THEME_COLOR
			-- Theme color.

feature -- Change Element

	set_theme_color (a_theme: EG_THEME_COLOR)
				-- Set color kind to theme with a_theme
				-- mark rgb as Void
			do
				theme_color := a_theme
				rgb_color := Void
			ensure
				theme_set: theme_color = a_theme
				rgb_unset: rgb_color = Void
			end

	set_rgb (a_rgb: EG_COLOR)
			-- Set color kind to rgb
			-- unset theme
		do
			rgb_color := a_rgb
			theme_color := void
		ensure
			theme_unset: theme_color= Void
			rgb_set:  rgb_color = a_rgb
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			if attached rgb_color as l_rgb_color then

			end
			if attached theme_color as l_theme_color then
				Result.put (l_theme_color.to_json, "themeColor")
			end
		end

invariant
	kind_of_rgba: attached rgb_color implies theme_color = Void
	kind_of_theme: attached theme_color implies rgb_color = Void
end
