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

feature -- Access

	user_entered_value: detachable EG_EXTENDED_VALUE

feature -- Element Change

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- JSON representation of the current object.
		do
			create Result.make_empty
		end

end
