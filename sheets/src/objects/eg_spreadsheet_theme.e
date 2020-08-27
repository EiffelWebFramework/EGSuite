note
	description: "[
	OIbject representing a spreadsheet theme

	{
	  "primaryFontFamily": string,
	  "themeColors": [
	    {
	      object (ThemeColorPair)
	    }
	  ]
	}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#spreadsheettheme", "protocol=uri"

class
	EG_SPREADSHEET_THEME

feature -- Access

	primary_font_family: detachable STRING
		 -- Name of the primary font family.

	theme_colors: detachable LIST [EG_THEME_COLOR_PAIR]
		-- The spreadsheet theme color pairs.
		-- To update you must provide all theme color pairs.

feature -- Change Element

	set_primary_font_family (a_value: like primary_font_family)
		do
			primary_font_family := a_value
		ensure
			primary_font_family_set: primary_font_family = a_value
		end

	force_theme_color (a_color: EG_THEME_COLOR_PAIR)
		local
			l_theme_colors: like theme_colors
		do
			l_theme_colors := theme_colors
			if l_theme_colors /= Void then
				l_theme_colors.force (a_color)
			else
				create {ARRAYED_LIST[EG_THEME_COLOR_PAIR]} l_theme_colors.make (2)
				l_theme_colors.force (a_color)
			end
			theme_colors := l_theme_colors
		end

	set_theme_colors (a_colors: like theme_colors)
			-- Set the list `theme_colors` with `a_colors`.
		do
			theme_colors := a_colors
		ensure
			theme_colors_set: theme_colors = a_colors
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of current object
		local
			j_array: JSON_ARRAY
		do
			create Result.make_with_capacity (1)
			if attached primary_font_family as lf then
				Result.put (create {JSON_STRING}.make_from_string (lf), "primaryFontFamily")
			end
			if attached theme_colors as l_colors then
				create j_array.make (l_colors.count)
				across l_colors as ic loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "themeColors" )
			end

			-- theme_colors JSON_ARRAY
		end
end
