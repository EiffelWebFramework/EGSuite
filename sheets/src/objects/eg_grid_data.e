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

inherit
	ANY
		redefine
			out
		end


create
	make,
	make_from_json

feature {NONE} -- Initialization

	make (n: like row_data.count)
		do
			create row_data.make (n)
		end

	make_from_json (a_json_o: JSON_OBJECT)
		local
			l_rd: like row_data.item
		do
			check attached {JSON_ARRAY} a_json_o.item (Json_key_row_data) as l_jsa then
				create row_data.make (l_jsa.count)
				across
					l_jsa is l_json_row_data
				loop
					check
						is_json_object: attached {JSON_OBJECT} l_json_row_data as l_jso
					then
						create l_rd.make_from_json (l_jso)
						row_data.extend (l_rd)
					end
				end
			end
		end

feature -- Access

	Json_key_row_data: STRING = "rowData"

	row_data: ARRAYED_LIST[EG_ROW_DATA]
--	row_metadata
--	column_metadata

feature -- Output

	out: STRING
		local
			l_sep: STRING
		do
			l_sep := "%N"
			Result := ""
			Result.append ("row_data:")
			across
				row_data is l_val
			loop
				Result.append (l_val.out + l_sep)
			end
			if Result.ends_with (l_sep) then
				Result.remove_tail (l_sep.count)
			end
		end

end
