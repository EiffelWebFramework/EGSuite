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

feature -- Get

	get_from_id (a_spreadsheet_id: STRING_8; a_params: detachable EG_SPREADSHEET_PARAMETERS): detachable EG_SPREADSHEET
		note
			EIS:"name=get.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/get", "protocol=uri"
		require
			valid_id: not a_spreadsheet_id.is_empty
		deferred
		end


end
