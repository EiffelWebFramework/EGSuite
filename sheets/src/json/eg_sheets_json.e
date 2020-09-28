note
	description: "Summary description for {EG_SHEETS_JSON}."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SHEETS_JSON

inherit

	EG_SHEETS_I

create
	make

feature {NONE} -- Initialization

	make (a_code: READABLE_STRING_32)
		do
			create eg_sheets_api.make (a_code)
		end

feature -- Access

	last_status_code: INTEGER
			-- <Precuror>
		do
			if attached eg_sheets_api.last_response as l_response then
				Result := l_response.status
			end
		end

feature -- Post

	create_spreedsheet: EG_SPREADSHEET
			-- Creates a spreadsheet, returning the newly created spreadsheet.
		note
			EIS: "name=create.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/create", "protocol=uri"
		do
			create Result
			if attached eg_sheets_api.create_spreedsheet as s then
				if attached parsed_json (s) as j then
					Result := eg_spreadsheet (Void, j)
				else
					logger.write_error ("create_spreedsheet-> No result from parsed json: " + s)
				end
			else
				logger.write_error ("create_spreedsheet-> No result from API layer")
			end
		end

feature -- 	Get

	get_from_id (a_spreadsheet_id: STRING_8; a_params: detachable EG_SPREADSHEET_PARAMETERS): detachable EG_SPREADSHEET
		note
			EIS:"name=get.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/get", "protocol=uri"
		do
			if attached eg_sheets_api.get_from_id (a_spreadsheet_id, a_params) as s then
				if attached parsed_json (s) as j then
					Result := eg_spreadsheet (Void, j)
				else
					logger.write_error ("get_from_id-> No result from parsed json: " + s)
				end
			else
				logger.write_error ("create_spreedsheet-> No result from API layer")
			end
		end

feature -- Error

	last_error: detachable STRING
			-- Last error message.
			-- maybe we can create an specific EG_ERROR.

feature -- Implementation Factory

	eg_spreadsheet (a_spreadsheet: detachable like eg_spreadsheet; a_json: JSON_VALUE): EG_SPREADSHEET
			-- Create an object `EG_SPREADSHEET` from a representation `a_json`.
		do
			if a_spreadsheet /= Void then
				Result := a_spreadsheet
			else
				create Result
			end
			if attached string_value_from_json (a_json, "spreadsheetId") as l_id then
				Result.set_id (l_id)
			end
			if attached string_value_from_json (a_json, "spreadsheetUrl") as l_url then
				Result.set_url (l_url)
			end
			if attached {JSON_OBJECT} json_value (a_json, "properties") as l_properties then
				Result.set_protperty (eg_spreadsheet_properties (l_properties))
			end
			if attached {JSON_ARRAY} json_value (a_json, "sheets") as l_sheets then
				across l_sheets as ic loop
					Result.force_sheet (eg_sheet (ic.item))
				end
			else
				logger.write_warning ("eg_spreadsheet-> No defined sheets on this sheet...")
			end
			if attached {JSON_ARRAY} json_value (a_json, "namedRanges") as l_named_ranges then
				across l_named_ranges as ic loop
					Result.force_name_range (eg_named_ranges (ic.item))
				end
			end
			if attached {JSON_ARRAY} json_value (a_json, "developerMetadata") as l_developer_metadata then
				across l_developer_metadata as ic loop
					Result.force_developer_metadata (eg_developer_metadata (l_developer_metadata))
				end
			end

		end

feature {NONE} -- JSON To Eiffel

	eg_spreadsheet_properties (a_json: JSON_VALUE): EG_SPREADSHEET_PROPERTIES
			-- Create an object `EG_SPREADSHEET_PROPERTIES` from a json representation `a_json`.
		local
			l_cell_format: EG_CELL_FORMAT
			l_ri: EG_RECALCULATION_INTERVAL
		do
			create Result
			if attached string_value_from_json (a_json, "title") as l_title then
				Result.set_title (l_title)
			end
			if attached string_value_from_json (a_json, "locale") as l_locale then
				Result.set_locale (l_locale)
			end
			if attached string_value_from_json (a_json, "autoRecalc") as l_auto_recalc then
				create l_ri
				if l_auto_recalc.is_case_insensitive_equal ("ON_CHANGE") then
					l_ri.set_on_change
				elseif l_auto_recalc.is_case_insensitive_equal ("MINUTE") then
					l_ri.set_minute
				elseif l_auto_recalc.is_case_insensitive_equal ("HOUR") then
					l_ri.set_hour
				end
				Result.set_auto_recalc (l_ri)
			end
			if attached string_value_from_json (a_json, "timeZone") as l_time_zone then
				Result.set_time_zone (l_time_zone)
			end
			if attached {JSON_OBJECT} json_value (a_json, "defaultFormat") as l_default_format then
				Result.set_default_format (cell_format (l_default_format))
			end
			if attached {JSON_OBJECT} json_value (a_json, "iterativeCalculationSettings") as  iterativeCalculationSettings then
				-- Result.set_iterative_calculation_settings (a_iterative_calculation_settings: [like iterative_calculation_settings] detachable EG_ITERATIVE_CALCULATION_SETTINGS)
			end
			if attached {JSON_OBJECT} json_value (a_json, "spreadsheetTheme") as l_spreadsheet then
				Result.set_spreadsheet_theme (spreadsheet_theme (l_spreadsheet))
			end
		end

	spreadsheet_theme (a_json: JSON_VALUE): EG_SPREADSHEET_THEME
			-- Create an object `EG_SPREADSHEET_THEME` from a json representation `a_json`.
		do
			create Result
			if attached string_value_from_json (a_json, "primaryFontFamily") as l_primary_font then
				Result.set_primary_font_family (l_primary_font)
			end
			if attached {JSON_ARRAY} json_value (a_json, "themeColors") as l_theme_colors then
				across l_theme_colors as ic  loop
					Result.force_theme_color (theme_color_pair (ic.item))
				end
			end
		end

	theme_color_pair (a_json: JSON_VALUE): EG_THEME_COLOR_PAIR
		local
			l_tc: EG_THEME_COLOR
		do
			create Result
			if attached string_value_from_json (a_json, "colorType") as l_color_type then
				create l_tc
				if l_color_type.is_case_insensitive_equal ("TEXT") then
					l_tc.set_text
				elseif l_color_type.is_case_insensitive_equal ("BACKGROUND") then
					l_tc.set_background
				elseif l_color_type.is_case_insensitive_equal ("ACCENT1") then
					l_tc.set_accent1
				elseif l_color_type.is_case_insensitive_equal ("ACCENT2") then
					l_tc.set_accent2
				elseif l_color_type.is_case_insensitive_equal ("ACCENT3") then
					l_tc.set_accent3
				elseif l_color_type.is_case_insensitive_equal ("ACCENT4") then
					l_tc.set_accent4
				elseif l_color_type.is_case_insensitive_equal ("ACCENT5") then
					l_tc.set_accent5
				elseif l_color_type.is_case_insensitive_equal ("ACCENT6") then
					l_tc.set_accent6
				elseif l_color_type.is_case_insensitive_equal ("LINK") then
					l_tc.set_link
				end
				Result.set_color_type (l_tc)
			end
			if attached {JSON_OBJECT} json_value (a_json, "color") as l_color  then
				Result.set_color (eg_color_style (l_color))
			end

		end

	cell_format (a_json: JSON_OBJECT): EG_CELL_FORMAT
			-- Create an object `EG_CELL_FORMAT` from a json representation `a_json`
		local
			l_vl: EG_VERTICAL_ALIGN
			l_ws: EG_WRAP_STRATEGY
			l_hl: EG_HORIZONTAL_ALIGN
			l_td: EG_TEXT_DIRECTION
			l_hyper: EG_HYPERLINK_DISPLAY_TYPE
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "numberFormat") as l_number_format then
				Result.set_number_format (Void)
			end

			if attached {JSON_OBJECT} json_value (a_json, "backgroundColor") as l_background_color then
				Result.set_background_color (eg_color (l_background_color))
			end
			if attached {JSON_OBJECT} json_value (a_json, "backgroundColorStyle") as l_background_color_style then
				Result.set_background_color_style (eg_color_style (l_background_color_style))
			end
			if attached {JSON_OBJECT} json_value (a_json, "borders") as l_borders then
				Result.set_borders (Void)
			end
			if attached {JSON_OBJECT} json_value (a_json, "padding") as l_padding then
				Result.set_padding (padding (l_padding))
			end
			if attached string_value_from_json (a_json, "horizontalAlignment") as l_alignment then
				create l_hl
				if l_alignment.is_case_insensitive_equal ("LEFT") then
					l_hl.set_left
				elseif l_alignment.is_case_insensitive_equal ("CENTER") then
					l_hl.set_center
				elseif l_alignment.is_case_insensitive_equal ("RIGHT") then
					l_hl.set_right
				end
				Result.set_horizontal_alignment (l_hl)
			end
			if attached string_value_from_json (a_json, "verticalAlignment") as l_alignment then
				create l_vl
				if l_alignment.is_case_insensitive_equal ("BOTTOM") then
					l_vl.set_bottom
				elseif l_alignment.is_case_insensitive_equal ("MIDDLE") then
					l_vl.set_middle
				elseif l_alignment.is_case_insensitive_equal ("TOP") then
					l_vl.set_top
				end
				Result.set_vertical_alignment (l_vl)
			end
			if attached string_value_from_json (a_json, "wrapStrategy") as l_wrap_strategy then
				create l_ws
				if l_wrap_strategy.is_case_insensitive_equal ("OVERFLOW_CELL") then
					l_ws.set_overflow_cell
				end
				if l_wrap_strategy.is_case_insensitive_equal ("LEGACY_WRAP") then
					l_ws.set_legacy_wrap
				elseif l_wrap_strategy.is_case_insensitive_equal ("CLIP") then
					l_ws.set_clip
				elseif l_wrap_strategy.is_case_insensitive_equal ("WRAP") then
					l_ws.set_wrap
				end
				Result.set_wrap_strategy (l_ws)
			end
			if attached string_value_from_json (a_json, "textDirection") as l_text_direction then
				create l_td
				if l_text_direction.is_case_insensitive_equal ("LEFT_TO_RIGHT") then
					l_td.set_left_to_right
				end
				if l_text_direction.is_case_insensitive_equal ("RIGHT_TO_LEFT") then
					l_td.set_right_to_left
				end
				Result.set_text_direction (l_td)
			end
			if attached {JSON_OBJECT} json_value (a_json, "textFormat") as l_text_format then
				Result.set_text_format (text_format (l_text_format))
			end
			if attached string_value_from_json (a_json, "hyperlinkDisplayType") as hyperlink then
				create l_hyper
				if hyperlink.is_case_insensitive_equal ("LINKED") then
					l_hyper.set_linked
				end
				if hyperlink.is_case_insensitive_equal ("PLAIN_TEXT") then
					l_hyper.set_plain_text
				end
				Result.set_hyperlink_display_type (l_hyper)
			end
			if attached {JSON_OBJECT} json_value (a_json, "textRotation") as l_text_rotation then
				Result.set_text_rotation (text_rotation (l_text_rotation))
			end
		end

	text_rotation (a_json: JSON_OBJECT): EG_TEXT_ROTATION
			-- Create an object `EG_TEXT_ROTATION` from a json representation.
		do
			create Result
			if attached integer_value_from_json (a_json, "angle") as l_val then
				Result.set_angle (l_val)
			end
			if attached boolean_value_from_json (a_json, "vertical") as l_val then
				Result.set_vertical (l_val)
			end
		end

	eg_color (a_json: JSON_OBJECT): EG_COLOR
			-- Create an object `EG_COLOR` from a json rerpesentation `a_json`.
		do
			create Result
			if attached real_value_from_json (a_json, "red") as l_val then
				Result.set_red (l_val)
			end
			if attached real_value_from_json (a_json, "green") as l_val then
				Result.set_green (l_val)
			end
			if attached real_value_from_json (a_json, "blue") as l_val then
				Result.set_blue (l_val)
			end
			if attached real_value_from_json (a_json, "alpha") as l_val then
				Result.set_alpha (l_val)
			end
		end

	padding (a_json: JSON_OBJECT): EG_PADDING
			-- Create an object `EG_PADDING` from a json representation `a_json`.
		do
			create Result
			if attached integer_value_from_json (a_json, "top") as l_val then
				Result.set_top (l_val)
			end
			if attached integer_value_from_json (a_json, "right") as l_val then
				Result.set_right (l_val)
			end
			if attached integer_value_from_json (a_json, "bottom") as l_val then
				Result.set_bottom (l_val)
			end
			if attached integer_value_from_json (a_json, "left") as l_val then
				Result.set_left (l_val)
			end
		end

	text_format (a_json: JSON_OBJECT): EG_TEXT_FORMAT
			-- Create an object `EG_TEXT_FORMAT` from a json representation `a_json`.
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "foregroundColor") as l_foreground_color then
				Result.set_foreground_color (eg_color (l_foreground_color))
			end
			if attached {JSON_OBJECT} json_value (a_json, "foregroundColorStyle") as l_foreground_color_style then
				Result.set_foreground_color_style (eg_color_style (l_foreground_color_style))
			end
			if attached string_value_from_json (a_json, "fontFamily") as l_font_family then
				Result.set_font_family (l_font_family)
			end
			if attached integer_value_from_json (a_json, "fontSize") as l_font_size then
				Result.set_font_size (l_font_size)
			end
			if attached boolean_value_from_json (a_json, "bold") as l_bold then
				Result.set_bold (l_bold)
			end
			if attached boolean_value_from_json (a_json, "italic") as l_italic then
				Result.set_italic (l_italic)
			end
			if attached boolean_value_from_json (a_json, "strikethrough") as l_strikethrough then
				Result.set_strikethrough (l_strikethrough)
			end
			if attached boolean_value_from_json (a_json, "underline") as l_underline then
				Result.set_strikethrough (l_underline)
			end
		end

	eg_color_style (a_json: JSON_OBJECT): EG_COLOR_STYLE
			-- Create an object `EG_COLOR_STYLE` from a json representation `a_json`.
		local
			l_tc: EG_THEME_COLOR
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "rgbColor") as l_rgbcolor then
				Result.set_rgb (eg_color (l_rgbcolor))
			elseif
				attached string_value_from_json (a_json, "themeColor") as l_theme_color
			then
				create l_tc
				if l_theme_color.is_case_insensitive_equal ("TEXT") then
					l_tc.set_text
				elseif l_theme_color.is_case_insensitive_equal ("BACKGROUND") then
					l_tc.set_background
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT1") then
					l_tc.set_accent1
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT2") then
					l_tc.set_accent2
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT3") then
					l_tc.set_accent3
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT4") then
					l_tc.set_accent4
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT5") then
					l_tc.set_accent5
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT6") then
					l_tc.set_accent6
				elseif l_theme_color.is_case_insensitive_equal ("LINK") then
					l_tc.set_link
				end
				Result.set_theme_color (l_tc)
			end
		end

	eg_sheet (a_json: JSON_VALUE): EG_SHEET
			-- Create an object `EG_SHEET` from a json representation `a_json`.
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "properties") as l_properties then
				Result.set_properties (sheet_properties (l_properties))
			end
			if attached {JSON_ARRAY} json_value (a_json, "data") as l_data then
					-- TODO
				Result.set_data (sheet_data (l_data))
			end
			if attached {JSON_ARRAY} json_value (a_json, "merges") as l_merges then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "conditionalFormats") as l_conditional_formats then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "filterViews") as l_filter_views then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "protectedRanges") as l_protected_ranges then
					-- TODO
			end
			if attached {JSON_OBJECT} json_value (a_json, "basicFilter") as l_basic_filter then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "charts") as l_charts then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "bandedRanges") as l_banded_ranges then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "developerMetadata") as l_developer_metadata then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "rowGroups") as l_row_groups then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "columnGroups") as l_column_groups then
					-- TODO
			end
			if attached {JSON_ARRAY} json_value (a_json, "slicers") as l_slicers then
					-- TODO
			end
		end

	eg_named_ranges (a_json: JSON_VALUE): EG_NAMED_RANGE
			-- Create an object `EG_NAMED_RANGE` from a json representation.
		do
			create Result
			if attached string_value_from_json (a_json, "namedRangeId") as l_named_range then
				Result.set_name_range (l_named_range)
			end
			if attached string_value_from_json (a_json, "name") as l_named then
				Result.set_name (l_named)
			end
			if attached {JSON_OBJECT} json_value (a_json, "range") as l_range  then
				Result.set_range (eg_grid_range (l_range))
			end
		end

	sheet_properties (a_json: JSON_VALUE): EG_SHEET_PROPERTIES
			-- Create an object `EG_SHEET_PROPERTIES` from a json representation `a_json`.
		do
			create Result
			if attached integer_value_from_json (a_json, "sheetId") as l_sheetId then
				Result.set_sheet_id (l_sheetId)
			end
			if attached string_value_from_json (a_json, "title") as l_title then
				Result.set_title (l_title)
				logger.write_debug ("sheet_properties->title set: " + l_title)
			end
			if attached integer_value_from_json (a_json, "index") as l_index then
				Result.set_index (l_index)
			end
			if attached string_value_from_json (a_json, "sheetType") as l_sheet_type then
				if l_sheet_type.is_case_insensitive_equal ("GRID") then
					Result.sheet_type.set_grid
				elseif l_sheet_type.is_case_insensitive_equal ("OBJECT") then
					Result.sheet_type.set_grid
				end
			end
			if attached {JSON_OBJECT} json_value (a_json, "gridProperties") as l_grid_properties then
				if attached integer_value_from_json (l_grid_properties, "rowCount") as l_row_count then
					Result.grid_properties.set_row_count (l_row_count)
				end
				if attached integer_value_from_json (l_grid_properties, "columnCount") as l_column_count then
					Result.grid_properties.set_column_count (l_column_count)
				end
			end
			if attached boolean_value_from_json (a_json, "hidden") as l_hidden then
				Result.set_hidden (l_hidden)
			end
			if attached {JSON_OBJECT} json_value (a_json, "tabColor") as l_color then
				Result.set_tab_color (eg_color (l_color))
			end
			if attached {JSON_OBJECT} json_value (a_json, "tabColorStyle") as l_color_style then
				Result.set_tab_color_style (eg_color_style (l_color_style))
			end
			if attached boolean_value_from_json (a_json, "rightToLeft") as l_rtl then
				Result.set_right_to_left (l_rtl)
			end
		end

	sheet_data (a_json_arr: JSON_ARRAY): like {EG_SHEET}.data
		do
			logger.write_debug ("sheet_data->")
--			create {ARRAYED_LIST} Result.make (a_json_arr.count)
			across
				a_json_arr is l_json_o_item
			loop
				check
					attached {JSON_OBJECT} l_json_o_item as l_jso
				then

				end
			end
		end

	eg_grid_range (a_json: JSON_VALUE): EG_GRID_RANGE
			-- Create an object `EG_GRID_RANGE` from a json representation `a_json`.
		do
			create Result
			if attached integer_value_from_json (a_json, "sheetId") as l_sheet_id then
				Result.set_sheet_id (l_sheet_id)
			end
			if attached integer_value_from_json (a_json, "startRowIndex") as l_start_row_index then
				Result.set_start_row_index (l_start_row_index)
			end
			if attached integer_value_from_json (a_json, "endRowIndex") as l_end_row_index then
				Result.set_end_row_index (l_end_row_index)
			end
			if attached integer_value_from_json (a_json, "startColumnIndex") as l_start_column_index then
				Result.set_start_column_index (l_start_column_index)
			end
			if attached integer_value_from_json (a_json, "endColumnIndex") as l_end_column_index then
				Result.set_end_column_index (l_end_column_index)
			end
		end

	eg_developer_metadata (a_json: JSON_VALUE): EG_DEVELOPER_METADATA
			-- Create an object `EG_DEVELOPER_METADATA` from a json representation `a_json`.
		local
			l_vs: EG_DEVELOPER_METADATA_VISIBILITY
		do
			create Result
			if attached integer_value_from_json (a_json, "metadataId") as l_metadata_id then
				Result.set_metadata_id (l_metadata_id)
			end
			if attached string_value_from_json (a_json, "metadataKey") as l_metadata_key then
				Result.set_metadata_key (l_metadata_key)
			end
			if attached string_value_from_json (a_json, "metadataValue") as l_metadata_value then
				Result.set_metadata_value (l_metadata_value)
			end
			if attached {JSON_OBJECT} json_value (a_json, "location") as l_location then
				Result.set_location (developer_metadata_location (l_location))
			end
			if attached string_value_from_json (a_json, "visibility") as l_visibility then
				create l_vs
				if l_visibility.is_case_insensitive_equal ("DOCUMENT") then
					l_vs.set_document
				elseif l_visibility.is_case_insensitive_equal ("PROJECT") then
					l_vs.set_project
				end
				Result.set_visibility (l_vs)
			end
		end


	developer_metadata_location (a_json: JSON_VALUE): EG_DEVELOPER_METADATA_LOCATION
		do
			create Result
			-- TOSO
		end

feature {NONE} -- Implementation

	eg_sheets_api: EG_SHEETS_API
			-- GSuite SpreeedSheets API object.

	last_json: detachable JSON_VALUE

	parsed_json (a_json_text: STRING): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end

	json_value (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [STRING]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						create l_id.make_from_string (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end

	internal_print_json_data (a_json_data: detachable JSON_VALUE; a_offset: STRING)
		local
			obj: HASH_TABLE [JSON_VALUE, JSON_STRING]
		do
			if attached {JSON_OBJECT} a_json_data as v_data then
				obj := v_data.map_representation
				from
					obj.start
				until
					obj.after
				loop
					print (a_offset)
					print (obj.key_for_iteration.item)
					if attached {JSON_STRING} obj.item_for_iteration as j_s then
						print (": " + j_s.item)
					elseif attached {JSON_NUMBER} obj.item_for_iteration as j_n then
						print (": " + j_n.item)
					elseif attached {JSON_BOOLEAN} obj.item_for_iteration as j_b then
						print (": " + j_b.item.out)
					elseif attached {JSON_NULL} obj.item_for_iteration as j_null then
						print (": NULL")
					elseif attached {JSON_ARRAY} obj.item_for_iteration as j_a then
						print (": {%N")
						internal_print_json_data (j_a, a_offset + "  ")
						print (a_offset + "}")
					elseif attached {JSON_OBJECT} obj.item_for_iteration as j_o then
						print (": {%N")
						internal_print_json_data (j_o, a_offset + "  ")
						print (a_offset + "}")
					end
					print ("%N")
					obj.forth
				end
			end
		end

	integer_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.integer_type
			then
				Result := v.item.to_integer
			end
		end

	integer_64_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER_64
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.is_number
			then
				Result := v.integer_64_item
			end
		end

	real_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): REAL
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.real_type
			then
				Result := v.item.to_real
			end
		end

	boolean_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string32_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_32
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_32
			end
		end

	unescaped_string_8_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_8
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_8
			end
		end

	integer_tuple_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable TUPLE [INTEGER, INTEGER]
		do
			if
				attached {JSON_ARRAY} json_value (a_json_data, a_id) as v and then
				v.count = 2 and then attached {JSON_NUMBER} v.i_th (1) as l_index_1 and then
				attached {JSON_NUMBER} v.i_th (2) as l_index_2 and then
				l_index_1.numeric_type = l_index_1.integer_type and then
				l_index_2.numeric_type = l_index_2.integer_type
			then
				Result := [l_index_1.item.to_integer, l_index_2.item.to_integer]
			end
		end

end
