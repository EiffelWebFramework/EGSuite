note
	description: "[
		Theme color types.
		SpreadsheetProperties contain a SpreadsheetTheme that defines a mapping of these theme color types to concrete colors.

			Enums
			THEME_COLOR_TYPE_UNSPECIFIED	Unspecified theme color
			TEXT							Represents the primary text color
			BACKGROUND						Represents the primary background color
			ACCENT1							Represents the first accent color
			ACCENT2							Represents the second accent color
			ACCENT3							Represents the third accent color
			ACCENT4							Represents the fourth accent color
			ACCENT5							Represents the fifth accent color
			ACCENT6							Represents the sixth accent color
			LINK							Represents the color to use for hyperlinks

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Theme Color", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#themecolortype", "protocol=uri"
class
	EG_THEME_COLOR

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
			set_value (theme_color_type_unspecified)
		end

	theme_color_type_unspecified: INTEGER = 1
			-- Unspecified theme color.

	text: INTEGER = 2
			-- Represents the primary text color.

	background: INTEGER = 3
			-- Represents the primary background color.

	accent1: INTEGER = 4
			-- Represents the first accent color.

	accent2: INTEGER = 5
			-- Represents the second accent color.

	accent3: INTEGER = 6
			-- Represents the third accent color.

	accent4: INTEGER = 7
			-- Represents the fourth accent color.

	accent5: INTEGER = 8
			-- Represents the fifth accent color.

	accent6: INTEGER = 9
			-- Represents the sixth accent color.

	link: INTEGER = 10
			-- Represents the color to use for hyperlinks.

feature -- Change Elements

	set_text
		do
			set_value (text)
		ensure
			value_set_with_text: value = text
		end

	set_background
		do
			set_value (background)
		ensure
			value_set_with_background: value = background
		end

	set_accent1
		do
			set_value (accent1)
		ensure
			value_set_with_accent1: value = accent1
		end

	set_accent2
		do
			set_value (accent2)
		ensure
			value_set_with_accent1: value = accent2
		end

	set_accent3
		do
			set_value (accent3)
		ensure
			value_set_with_accent3: value = accent3
		end

	set_accent4
		do
			set_value (accent4)
		ensure
			value_set_with_accent1: value = accent4
		end

	set_accent5
		do
			set_value (accent5)
		ensure
			value_set_with_accent1: value = accent5
		end

	set_accent6
		do
			set_value (accent6)
		ensure
			value_set_with_accent1: value = accent6
		end

	set_link
		do
			set_value (link)
		ensure
			value_set_with_accent1: value = link
		end

feature -- Status Report

	is_text: BOOLEAN
		do
			Result := value = text
		end

	is_background: BOOLEAN
		do
			Result := value = background
		end

	is_accent1: BOOLEAN
		do
			Result := value = accent1
		end

	is_accent2: BOOLEAN
		do
			Result := value = accent2
		end

	is_accent3: BOOLEAN
		do
			Result := value = accent3
		end

	is_accent4: BOOLEAN
		do
			Result := value = accent4
		end

	is_accent5: BOOLEAN
		do
			Result := value = accent5
		end

	is_accent6: BOOLEAN
		do
			Result := value = accent6
		end

	is_link: BOOLEAN
		do
			Result := value = link
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = theme_color_type_unspecified or else
			          a_value = text or else
			          a_value = background or else
			          a_value = accent1 or else
			          a_value = accent2 or else
			          a_value = accent3 or else
			          a_value = accent4 or else
			          a_value = accent5 or else
			          a_value = accent6 or else
			          a_value = link
		end


feature -- Eiffel to JSON

	to_json: JSON_STRING
			-- Json representation of current object.
		do
			if is_text then
				Result := "TEXT"
			elseif is_background then
				Result := "BACKGROUND"
			elseif is_accent1 then
				Result := "ACCENT1"
			elseif is_accent2 then
				Result := "ACCENT2"
			elseif is_accent3 then
				Result := "ACCENT3"
			elseif is_accent4 then
				Result := "ACCENT4"
			elseif is_accent5 then
				Result := "ACCENT5"
			elseif is_accent6 then
				Result := "ACCENT6"
			elseif is_link then
				Result := "LINK"
			else
				Result := "THEME_COLOR_TYPE_UNSPECIFIED"
			end

		end
end
