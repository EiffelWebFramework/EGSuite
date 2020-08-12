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
			create rgb_color
		end

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

invariant
	kind_of_rgba: attached rgb_color implies theme_color = Void
	kind_of_theme: attached theme_color implies rgb_color = Void
end
