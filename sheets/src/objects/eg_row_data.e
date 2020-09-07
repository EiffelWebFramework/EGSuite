note
	description: "[
		Data about each cell in a row.
		{
		   "values": [
		     {
		      object (CellData)
		    }
		  ]
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RawData", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#RowData", "protocol=uri"

class
	EG_ROW_DATA


feature -- Access

	values: detachable LIST [EG_CELL_DATA]
			-- The values in the row, one per column.


feature -- Element Change

	force_value (a_data: EG_CELL_DATA)
			-- Add an item `a_data`	to the list of `values`.
		local
			l_values: like values
		do
			l_values := values
			if l_values /= Void then
				l_values.force (a_data)
			else
				create {ARRAYED_LIST [EG_CELL_DATA]} l_values.make (5)
				l_values.force (a_data)
			end
			values := l_values
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of the current object.
		local
			j_array: JSON_ARRAY
		do
			create Result.make_empty
			if attached values as l_values then
				create j_array.make (l_values.count)
				across l_values as ic loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "values")
			end
		end
end
