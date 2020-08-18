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

inherit

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} --Initialize

	default_create
		do
			create primary_font_family.make_empty
			create {ARRAYED_LIST[EG_THEME_COLOR_PAIR]}theme_colors.make (0)
		end

feature -- Access


	primary_font_family: STRING
		 -- Name of the primary font family.

	theme_colors: LIST [EG_THEME_COLOR_PAIR]
		-- The spreadsheet theme color pairs.
		-- To update you must provide all theme color pairs.

feature -- Change Element

	set_primary_font_family (a_value: STRING)
		do
			primary_font_family := a_value
		ensure
			primary_font_family_set: primary_font_family = a_value
		end

	force_theme_color (a_color: EG_THEME_COLOR_PAIR)
		do
			theme_colors.force (a_color)
		end
end
