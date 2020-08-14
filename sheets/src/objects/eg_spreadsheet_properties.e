note
	description: "Object Representing properties of a spreedsheet."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#spreadsheetproperties", "protocol=uri"

class
	EG_SPREADSHEET_PROPERTIES
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
			create title.make_empty
			create locale.make_empty
			create auto_recalc
			create time_zone.make_empty
			create default_format
			create spreadsheet_theme
			create iterative_calculation_settings
		end

feature -- Access

	title: STRING
			--  The title of the spreadsheet.

	locale: STRING
			-- The locale of the spreadsheet in one of the following formats:
			--    an ISO 639-1 language code such as en
			--    an ISO 639-2 language code such as fil, if no 639-1 code exists
			--    a combination of the ISO language code and country code, such as en_US
			-- Note: when updating this field, not all locales/languages are supported.

	auto_recalc: EG_RECALCULATION_INTERVAL
			-- The amount of time to wait before volatile functions are recalculated.

	time_zone: STRING
			-- The time zone of the spreadsheet, in CLDR format such as America/New_York.
			-- If the time zone isn't recognized, this may be a custom time zone such as GMT-07:00.

	default_format: EG_CELL_FORMAT
			-- The default format of all cells in the spreadsheet.
			-- CellData.effectiveFormat will not be set if the cell's format is equal to this default format. This field is read-only.

	iterative_calculation_settings: detachable EG_ITERATIVE_CALCULATION_SETTINGS
			-- Determines whether and how circular references are resolved with iterative calculation.
			-- Absence of this field means that circular references result in calculation errors.

	spreadsheet_theme: EG_SPREADSHEET_THEME
			-- theme applied to the spreadsheet.


feature -- Element Change

	set_title (a_title: STRING)
			-- Set title with `a_title`.
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_locale (a_locale: STRING)
			-- Set locale with `a_locale`.
		do
			locale := a_locale
		ensure
			locale_set: locale = a_locale
		end

	set_time_zone (a_time_zone: STRING)
			-- Set time zone with `a_time_zone`
		do
			time_zone := a_time_zone
		end
end
