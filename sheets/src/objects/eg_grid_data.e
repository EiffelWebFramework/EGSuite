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

end
