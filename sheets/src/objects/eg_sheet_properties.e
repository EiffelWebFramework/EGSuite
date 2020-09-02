note
	description: "[
		Properties of a sheet.

		{
		  "sheetId": integer,
		  "title": string,
		  "index": integer,
		  "sheetType": enum (SheetType),
		  "gridProperties": {
		    object (GridProperties)
		  },
		  "hidden": boolean,
		  "tabColor": {
		    object (Color)
		  },
		  "tabColorStyle": {
		    object (ColorStyle)
		  },
		  "rightToLeft": boolean
		}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#SheetProperties", "protocol=uri"

class
	EG_SHEET_PROPERTIES

feature -- Access

	sheet_id: INTEGER
			-- The ID of the sheet. Must be non-negative. This field cannot be changed once set.
			-- NATURAL?

	title: detachable STRING
			-- The name of the sheet.

	index: INTEGER
			-- The index of the sheet within the spreadsheet.
			-- When adding or updating sheet properties, if this field is excluded then the sheet is added or moved to the end of the sheet list.
			-- When updating sheet indices or inserting sheets, movement is considered in "before the move" indexes.
			-- For example, if there were 3 sheets (S1, S2, S3) in order to move S1 ahead of S2 the index would have to be set to 2.
			-- A sheet index update request is ignored if the requested index is identical to the sheets current index or if the requested new index is equal to the current sheet index + 1.

	sheet_type: detachable EG_SHEET_TYPE
			-- The type of sheet. Defaults to GRID . This field cannot be changed once set.

	grid_properties: detachable EG_GRID_PROPERTIES
			-- Additional properties of the sheet if this sheet is a grid.
			-- (If the sheet is an object sheet, containing a chart or image, then this field will be absent.)
			-- When writing it is an error to set any grid properties on non-grid sheets.

	hidden: BOOLEAN
			-- True if the sheet is hidden in the UI, false if it's visible.

	tab_color: detachable EG_COLOR
			-- The color of the tab in the UI.

	tab_color_style: detachable EG_COLOR_STYLE
			-- The color of the tab in the UI. If tabColor is also set, this field takes precedence.

	right_to_left: BOOLEAN
			-- True if the sheet is an RTL sheet instead of an LTR sheet.


feature -- Status Report

	is_sheet_id_set: BOOLEAN
			-- sheet_id has been defined?	

	is_sheet_type_set: BOOLEAN
			-- sheet type has been defined?	

feature -- Element Change

	set_sheet_id (a_id:  like sheet_id)
			-- Set `sheet_id` with `a_id`.
		require
			non_negative: a_id >=0
			not_id_set: not is_sheet_id_set
		do
			sheet_id := a_id
			is_sheet_id_set := True
		ensure
			sheet_id_set: sheet_id = a_id
			is_defined: is_sheet_id_set
		end

	set_title (a_title: like title)
			-- Set `title` with `a_title`.
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_index (a_index: like index)
			-- Set `index` with `a_index`.
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

	set_sheet_type (a_type: EG_SHEET_TYPE)
			-- Set `sheet_type` with `a_type`.
		require
			not_sheet_type: not is_sheet_type_set
		do
			sheet_type := a_type
			is_sheet_type_set := True
		ensure
			sheet_type_set: sheet_type = a_type
			sheet_type_defined: is_sheet_type_set
		end

	set_grid_properties (a_properties: like grid_properties)
			-- Set `grid_properties` with `a_properties`.
		do
			grid_properties := a_properties
		ensure
			grid_properties_set: grid_properties = a_properties
		end

	set_hidden (a_val: BOOLEAN)
			-- Set `hidden` with `a_val`.
		do
			hidden := a_val
		ensure
			hidden_set: hidden = a_val
		end

	set_tab_color (a_color: like tab_color)
			-- Set `tab_color` with `a_color`.
		do
			tab_color := a_color
		ensure
			tab_color_set: tab_color = a_color
		end

	set_tab_color_style (a_color_style: like tab_color_style)
			-- Set `tab_color_style` with `a_color_style`.
		do
			tab_color_style := a_color_style
		ensure
			tab_color_style_set: tab_color_style = a_color_style
		end

	set_right_to_left (a_val: BOOLEAN)
			-- Set `right_to_left` with `a_val`.
		do
			right_to_left := a_val
		ensure
			right_to_left_set: right_to_left = a_val
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- JSON Representation of current object.
		do
			create Result.make
			if is_sheet_id_set then
				Result.put (create {JSON_NUMBER}.make_integer (sheet_id), "sheetId")
			end
			if attached title as l_title then
				Result.put (create {JSON_STRING}.make_from_string (l_title), "title")
			end
			Result.put (create {JSON_NUMBER}.make_integer (index), "index")
			if attached sheet_type as l_st then
				Result.put (l_st.to_json, "sheetType")
			end
			if attached grid_properties as l_gp then
				Result.put (l_gp.to_json, "gridProperties")
			end
			Result.put (create {JSON_BOOLEAN}.make (hidden), "hidden")
			if attached tab_color as l_tc then
				Result.put (l_tc.to_json, "tabColor")
			end
			if attached tab_color_style as l_tcs then
				Result.put (l_tcs.to_json, "tabColorStyle")
			end
			Result.put (create {JSON_BOOLEAN}.make (right_to_left), "rightToLeft")
		end

end
