note
	description: "Summary description for {TEST_SHEETS_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SHEETS_I

inherit

	APPLICATION_FLOW

create
	make

feature -- {NONE}

	make
		local
			l_sheet_id: STRING
			l_param: EG_SPREADSHEET_PARAMETERS
		do
			logger.write_information ("make-> ======================> Starting application")
			set_from_json_credentials_file_path (create {PATH}.make_from_string (CREDENTIALS_PATH))
			retrieve_access_token
				-- Test default.
			logger.write_information ("Get spreadsheet from id without parameters")
			test_get_sheet ("1j5CTkpgOc6Y5qgYdA_klZYjNhmN2KYocoZAdM4Y61tw", Void)
--			logger.write_information ("Get spreadsheet from id with parameters")
--			create l_param.make (2)
--			l_param.include_grid_data (True)
--			test_get_sheet ("1j5CTkpgOc6Y5qgYdA_klZYjNhmN2KYocoZAdM4Y61tw", l_param)


			-- PG
			l_sheet_id := "19cKCmQBWJoMePX0Iy6LueHRw0sS2bMcyP1Auzbkvj6M"
			create l_param.make (2)
			l_param.include_grid_data (True)
			test_get_sheet (l_sheet_id, l_param)
		end


feature -- Test

	test_get_sheet (a_id: STRING_8; a_param: detachable EG_SPREADSHEET_PARAMETERS)
		local
			l_esapi: EG_SHEETS_I
		do
			create {EG_SHEETS_JSON} l_esapi.make (last_token.token)
			if attached {EG_SPREADSHEET} l_esapi.get_from_id (a_id, a_param) as l_spread_sheet then
				logger.write_debug (l_spread_sheet.to_json.representation)
			else
				logger.write_error ("Error " + l_esapi.last_status_code.out)
			end
		end

feature {NONE} -- Implementations

	CREDENTIALS_PATH: STRING = "/home/pg/tmp/EGSheets-itadmin-api-project-credentials.json"
			-- Credentials path to json file.

end
