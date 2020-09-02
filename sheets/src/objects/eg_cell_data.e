note
	description: "[
	Data about a specific cell.
	
		{
		  "userEnteredValue": {
		    object (ExtendedValue)
		  },
		  "effectiveValue": {
		    object (ExtendedValue)
		  },
		  "formattedValue": string,
		  "userEnteredFormat": {
		    object (CellFormat)
		  },
		  "effectiveFormat": {
		    object (CellFormat)
		  },
		  "hyperlink": string,
		  "note": string,
		  "textFormatRuns": [
		    {
		      object (TextFormatRun)
		    }
		  ],
		  "dataValidation": {
		    object (DataValidationRule)
		  },
		  "pivotTable": {
		    object (PivotTable)
		  }
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=CellData", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#CellData", "protocol=uri"

class
	EG_CELL_DATA

end
