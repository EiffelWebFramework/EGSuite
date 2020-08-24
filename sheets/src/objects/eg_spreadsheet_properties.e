note
	description: "[
						Object Representing properties of a spreedsheet.]
						
						JSON representation
				
						{
						  "title": string,
						  "locale": string,
						  "autoRecalc": enum (RecalculationInterval),
						  "timeZone": string,
						  "defaultFormat": {
						    object (CellFormat)
						  },
						  "iterativeCalculationSettings": {
						    object (IterativeCalculationSettings)
						  },
						  "spreadsheetTheme": {
						    object (SpreadsheetTheme)
						  }
						}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#spreadsheetproperties", "protocol=uri"

class
	EG_SPREADSHEET_PROPERTIES


feature -- Access

	title: detachable STRING
			--  The title of the spreadsheet.

	locale: detachable STRING
			-- The locale of the spreadsheet in one of the following formats:
			--    an ISO 639-1 language code such as en
			--    an ISO 639-2 language code such as fil, if no 639-1 code exists
			--    a combination of the ISO language code and country code, such as en_US
			-- Note: when updating this field, not all locales/languages are supported.

	auto_recalc: detachable EG_RECALCULATION_INTERVAL
			-- The amount of time to wait before volatile functions are recalculated.

	time_zone: detachable STRING
			-- The time zone of the spreadsheet, in CLDR format such as America/New_York.
			-- If the time zone isn't recognized, this may be a custom time zone such as GMT-07:00.

	default_format: detachable EG_CELL_FORMAT
			-- The default format of all cells in the spreadsheet.
			-- CellData.effectiveFormat will not be set if the cell's format is equal to this default format. This field is read-only.

	iterative_calculation_settings: detachable EG_ITERATIVE_CALCULATION_SETTINGS
			-- Determines whether and how circular references are resolved with iterative calculation.
			-- Absence of this field means that circular references result in calculation errors.

	spreadsheet_theme: detachable EG_SPREADSHEET_THEME
			-- theme applied to the spreadsheet.

feature -- Element Change

	set_title (a_title: like title)
			-- Set `title` with `a_title`.
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_locale (a_locale: like locale)
			-- Set `locale` with `a_locale`.
		do
			locale := a_locale
		ensure
			locale_set: locale = a_locale
		end

	set_time_zone (a_time_zone: like time_zone)
			-- Set `time_zone` with `a_time_zone`
		do
			time_zone := a_time_zone
		ensure
			time_zone_set: time_zone = a_time_zone
		end

	set_default_format (a_format: like default_format)
			-- Set `default_format` with `format`.
		do
			default_format := a_format
		ensure
			default_format_set: default_format = a_format
		end

	set_iterative_calculation_settings (a_iterative_calculation_settings: like iterative_calculation_settings)
			-- Set `iterative_calculation_settings` with `a_iterative_calculation_settings`.
		do
			iterative_calculation_settings := a_iterative_calculation_settings
		ensure
			iterative_calculation_settings_set: iterative_calculation_settings = a_iterative_calculation_settings
		end

	set_spreadsheet_theme (a_theme: like spreadsheet_theme)
		do
			spreadsheet_theme := a_theme
		ensure
			spreadsheet_theme_set: spreadsheet_theme = a_theme
		end

	set_auto_recalc (a_auto_recalc: like auto_recalc)
			-- Set auto_recalc with `a_auto_recalc`.
		do
			auto_recalc := a_auto_recalc
		ensure
			auto_recalc_set: auto_recalc = a_auto_recalc
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of the current object
		do
			create Result.make_empty
			if attached title as l_title then
				Result.put (create {JSON_STRING}.make_from_string (l_title), "title")
			end
			if attached locale as l_locale then
				Result.put (create {JSON_STRING}.make_from_string (l_locale), "locale")
			end
			if attached auto_recalc as l_auto_recalc then
				Result.put (l_auto_recalc.to_json, "autoRecalc")
			end
			if attached time_zone as l_time_zone then
				Result.put (create {JSON_STRING}.make_from_string (l_time_zone), "timeZone")
			end
			if attached iterative_calculation_settings  as l_ics then
				Result.put (l_ics.to_json, "iterativeCalculationSettings")
			end
			if attached spreadsheet_theme as l_sp then
				Result.put (l_sp.to_json, "spreadsheetTheme")
			end
		end

end
