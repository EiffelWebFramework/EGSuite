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

end
