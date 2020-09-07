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

	force_row_data (a_data: EG_ROW_DATA)
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

	set_row_data (a_data: like row_data)
			-- Set `row_data` with `a_data`.
		do
			row_data := a_data
		ensure
			row_data_set: row_data = a_data
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

	set_row_metadata (a_data: like row_metadata)
			-- Set `row_metadata` with `a_data`.
		do
			row_metadata := a_data
		ensure
			row_metadata_set: row_metadata = a_data
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

	set_column_metadata	(a_data: like column_metadata)
			-- Set `column_metadata` with `a_data`.
		do
			column_metadata := a_data
		ensure
			column_metadata_set: column_metadata = a_data
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			--Json representation of the current object.
		local
			j_array: JSON_ARRAY
		do
			create Result.make_empty
			Result.put (create {JSON_NUMBER}.make_integer (start_row), "startRow")
			Result.put (create {JSON_NUMBER}.make_integer (start_column), "startColumn")
			if attached row_data as l_rd then
				create j_array.make (l_rd.count)
				across l_rd as ic  loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "rowData")
			end
			if attached row_metadata as l_rm then
				create j_array.make (l_rm.count)
				across l_rm as ic loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "rowMetadata")
			end
			if attached column_metadata as l_cm then
				create j_array.make (l_cm.count)
				across l_cm as ic loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "columnMetadata")
			end

		end
end
