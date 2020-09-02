note
	description: "[
	Data in the grid, as well as metadata about the dimensions.
	
	{
	  "startRow": integer,
	  "startColumn": integer,
	  "rowData": [
	    {
	      object (RowData)
	    }
	  ],
	  "rowMetadata": [
	    {
	      object (DimensionProperties)
	    }
	  ],
	  "columnMetadata": [
	    {
	      object (DimensionProperties)
	    }
	  ]
	}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#griddata", "protocol=uri"
class
	EG_GRID_DATA

feature -- Access

	start_row: INTEGER
			-- The first row this GridData refers to, zero-based.

	start_column: INTEGER
			-- The first column this GridData refers to, zero-based.

	row_data: detachable LIST [EG_ROW_DATA]
			-- The data in the grid, one entry per row, starting with the row in startRow.
			-- The values in RowData will correspond to columns starting at startColumn .

	row_metadata: detachable LIST [EG_DIMENSION_PROPERTIES]
			-- Metadata about the requested rows in the grid, starting with the row in startRow

	column_metadata: detachable LIST [EG_DIMENSION_PROPERTIES]
			-- Metadata about the requested columns in the grid, starting with the column in startColumn .

feature -- Element Change

	set_start_row (a_val: like start_row)
			-- Set `start_row` with `a_val`.
		require
			valid_row: a_val >= 0
		do
			start_row := a_val
		ensure
			start_row_set: start_row = a_val
		end

	set_start_column (a_val: like start_column)
			-- Set `start_column` with `a_val`.
		require
				valid_column: a_val >= 0
		do
			start_column := a_val
		ensure
			start_column_set: start_column = a_val
		end

	force_raw_data (a_data: EG_ROW_DATA)
			-- Add an item `a_data` to the list of `row_data`
		local
			l_row_data: like row_data
		do
			l_row_data := row_data
			if l_row_data /= Void then
				l_row_data.force (a_data)
			else
				create {ARRAYED_LIST [EG_ROW_DATA]} l_row_data.make (5)
				l_row_data.force (a_data)
			end
			row_data := l_row_data
		end

	force_row_metadata (a_metadata: EG_DIMENSION_PROPERTIES)
			-- Add an item `a_metadata` to the list of `row_metadata`
		local
			l_row_metadata: like row_metadata
		do
			l_row_metadata := row_metadata
			if l_row_metadata /= Void then
				l_row_metadata.force (a_metadata)
			else
				create {ARRAYED_LIST [EG_DIMENSION_PROPERTIES]} l_row_metadata.make (5)
				l_row_metadata.force (a_metadata)
			end
			row_metadata := l_row_metadata
		end


	force_column_metadata (a_metadata: EG_DIMENSION_PROPERTIES)
			-- Add an item `a_metadata` to the list of `column_metadata`
		local
			l_column_metadata: like row_metadata
		do
			l_column_metadata := row_metadata
			if l_column_metadata /= Void then
				l_column_metadata.force (a_metadata)
			else
				create {ARRAYED_LIST [EG_DIMENSION_PROPERTIES]} l_column_metadata.make (5)
				l_column_metadata.force (a_metadata)
			end
			column_metadata := l_column_metadata
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make
		end
end
