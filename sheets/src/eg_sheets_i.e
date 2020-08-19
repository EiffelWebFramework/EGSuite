note
	description: "Sheets API Interface: specify how to read and write Google Sheets data."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Rest API GSheets", "src=https://developers.google.com/sheets/api/reference/rest?apix=true", "protocol=urihttps://developers.google.com/sheets/api/reference/rest?apix=true"

deferred class
	EG_SHEETS_I


feature {NONE} -- Initialization

	make (a_code: READABLE_STRING_32)
		deferred
		end

feature -- Status Report

	last_status_code: INTEGER
			-- Return the HTTP status code from the last request.
		deferred
		end

feature -- Post

	create_spreedsheet: EG_SPREADSHEET
			-- Creates a spreadsheet, returning the newly created spreadsheet.
		note
			EIS:"name=create.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/create", "protocol=uri"
		deferred
		end


end
