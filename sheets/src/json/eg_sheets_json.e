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

	create_spreedsheet: EG_SPREEDSHEET
			-- Creates a spreadsheet, returning the newly created spreadsheet.
		note
			EIS:"name=create.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/create", "protocol=uri"
		do
			create Result
			if attached eg_sheets_api.create_spreedsheet  as s then
				if attached parsed_json (s) as j then
					Result := eg_spreadsheet (Void, j)
				else
					-- set error
				end
			end
		end

feature -- Error

	last_error: detachable STRING
			-- Last error message.
			-- maybe we can create an specific EG_ERROR.

feature -- Implementation Factory

	eg_spreadsheet (a_spreadsheet: detachable like eg_spreadsheet; a_json: JSON_VALUE): EG_SPREEDSHEET
			--
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
			Result.set_protperty (eg_spreadsheet_properties (a_json))
			if attached {JSON_ARRAY} json_value (a_json, "sheets") as l_sheets then
				across l_sheets as ic loop
				end
			end
			if attached {JSON_ARRAY} json_value (a_json, "namedRanges") as l_named_ranges then
			end
			if attached {JSON_ARRAY} json_value (a_json, "developerMetadata") as l_developer_metadata then
				-- TODO
			end


		end

feature {NONE} -- JSON To Eiffel

	eg_spreadsheet_properties (a_json: JSON_VALUE): EG_SPREADSHEET_PROPERTIES
			--
		local
			l_cell_format: EG_CELL_FORMAT
		do
			create Result
			if attached {JSON_OBJECT} json_value (a_json, "properties") as l_properties then
				if attached string_value_from_json (l_properties, "title") as l_title then
					Result.set_title (l_title)
				end
				if attached string_value_from_json (l_properties, "locale") as l_locale then
					Result.set_locale (l_locale)
				end
				if attached string_value_from_json (l_properties, "autoRecalc") as l_auto_recalc then
					if l_auto_recalc.is_case_insensitive_equal ("ON_CHANGE") then
						Result.auto_recalc.set_on_change
					elseif l_auto_recalc.is_case_insensitive_equal ("MINUTE") then
						Result.auto_recalc.set_minute
					elseif l_auto_recalc.is_case_insensitive_equal ("HOUR") then
						Result.auto_recalc.set_hour
					end
				end
				if attached string_value_from_json (l_properties, "timeZone") as l_time_zone then
					Result.set_time_zone (l_time_zone)
				end
				if attached {JSON_OBJECT} json_value (l_properties, "defaultFormat") as l_default_format then
				end
			end
		end


	default_format (a_json: JSON_OBJECT): EG_CELL_FORMAT
		do
			create Result

			if attached {JSON_OBJECT} json_value (a_json, "backgroundColor") as l_background_color then
				Result.set_background_color (eg_color (l_background_color))
			end
			if attached {JSON_OBJECT} json_value (a_json, "padding") as l_padding then
				Result.set_padding (padding (l_padding))
			end
			if attached string_value_from_json (a_json, "verticalAlignment") as l_alignment then
				if l_alignment.is_case_insensitive_equal ("BOTTOM")  then
					Result.vertical_alignment.set_bottom
				elseif l_alignment.is_case_insensitive_equal ("MIDDLE")  then
					Result.vertical_alignment.set_middle
				elseif l_alignment.is_case_insensitive_equal ("TOP")  then
					Result.vertical_alignment.set_top
				end
			end
			if attached string_value_from_json (a_json, "wrapStrategy") as l_wrap_strategy then
				if l_wrap_strategy.is_case_insensitive_equal ("OVERFLOW_CELL")  then
					Result.wrap_strategy.set_overflow_cell
				end
				if l_wrap_strategy.is_case_insensitive_equal ("LEGACY_WRAP")  then
					Result.wrap_strategy.set_legacy_wrap
				elseif l_wrap_strategy.is_case_insensitive_equal ("CLIP")  then
					Result.wrap_strategy.set_clip
				elseif l_wrap_strategy.is_case_insensitive_equal ("WRAP")  then
					Result.wrap_strategy.set_wrap
				end
			end
			if attached {JSON_OBJECT} json_value (a_json, "textFormat") as l_text_format then
				Result.set_text_format (text_format (l_text_format))
			end
			if attached {JSON_OBJECT} json_value (a_json, "backgroundColorStyle") as l_background_color_style then
				Result.set_background_color_style (eg_color_style (l_background_color_style))
			end
		end

	eg_color (a_json: JSON_OBJECT): EG_COLOR
		do
			create Result
			if attached integer_value_from_json (a_json, "red") as l_val then
				Result.set_red (l_val)
			elseif attached real_value_from_json (a_json, "red") as l_val then
				Result.set_red (l_val)
			end
			if attached integer_value_from_json (a_json, "green") as l_val then
				Result.set_green (l_val)
			elseif attached real_value_from_json (a_json, "green") as l_val then
				Result.set_green (l_val)
			end
			if attached integer_value_from_json (a_json, "blue") as l_val then
				Result.set_blue (l_val)
			elseif attached real_value_from_json (a_json, "blue") as l_val then
				Result.set_blue (l_val)
			end
			if attached integer_value_from_json (a_json, "alpha") as l_val then
				Result.set_alpha (l_val)
			elseif attached real_value_from_json (a_json, "alpha") as l_val then
				Result.set_alpha (l_val)
			end
		end

	padding (a_json: JSON_OBJECT): EG_PADDING
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
				if l_theme_color.is_case_insensitive_equal ("TEXT")  then
					l_tc.set_text
				elseif l_theme_color.is_case_insensitive_equal ("BACKGROUND")  then
					l_tc.set_background
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT1")  then
					l_tc.set_accent1
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT2")  then
					l_tc.set_accent2
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT3")  then
					l_tc.set_accent3
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT4")  then
					l_tc.set_accent4
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT5")  then
					l_tc.set_accent5
				elseif l_theme_color.is_case_insensitive_equal ("ACCENT6")  then
					l_tc.set_accent6
				elseif l_theme_color.is_case_insensitive_equal ("LINK")  then
					l_tc.set_link
				end
				Result.set_theme_color (l_tc)
			end
		end

	eg_sheets (a_json: JSON_VALUE): EG_SHEET
		do
			create Result
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
				obj	:= v_data.map_representation
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
