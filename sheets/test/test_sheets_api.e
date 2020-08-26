note
	description: "Summary description for {TEST_SHEETS_WITH_API_KEY}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SHEETS_API

inherit

	APPLICATION_FLOW

create
	make

feature -- {NONE}

	make
		do
			logger.write_information ("make-> ======================> Starting application")

			set_from_json_credentials_file_path (create {PATH}.make_from_string ("/home/pg/data/solarity/sit-dev/etc/opt/solarity/EGSheets-itadmin-api-project-credentials.json"))
			retrieve_access_token
--			test_create_sheet
--			test_get_sheet ("1v1N4nRa6mmLcP9rUuyQPiCnLuUcBQFDEC7E0CDg3ASI")
			test_append_sheet ("19cKCmQBWJoMePX0Iy6LueHRw0sS2bMcyP1Auzbkvj6M") --pg
			--test_append_sheet ("1j5CTkpgOc6Y5qgYdA_klZYjNhmN2KYocoZAdM4Y61tw") --jv

--			set_from_json_credentials_file_path (create {PATH}.make_from_string (CREDENTIALS_PATH))
			retrieve_access_token
			test_get_sheet ("1v1N4nRa6mmLcP9rUuyQPiCnLuUcBQFDEC7E0CDg3ASI")

		end


feature -- Tests

	test_create_sheet
		require
			token_is_valid
		local
			l_esapi: EG_SHEETS_API
		do
			-- https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets
			create l_esapi.make (last_token.token)
			if attached l_esapi.create_spreedsheet as l_spreedsheet then
				if l_esapi.has_error then
--					debug ("test_create_sheet")
						logger.write_error ("test_create_sheet-> Error" )
						print ("test_create_sheet-> Error: msg:" + l_esapi.error_message + "%N")
						print ("test_create_sheet-> See codes here: https://developers.google.com/maps-booking/reference/rest-api-v3/status_codes")
						print ("%N")
--					end
					check
						cannot_create_the_spreedsheet: False
					end
				else
					check  Json_Field_spreadsheetId: l_spreedsheet.has_substring ("spreadsheetId") end
					check  Json_Field_properties: l_spreedsheet.has_substring ("properties") end
					check  Json_Field_sheets: l_spreedsheet.has_substring ("sheets") end
					check  Json_Field_spreadsheetUrl: l_spreedsheet.has_substring ("spreadsheetUrl") end
						-- developerMetadata and namedRanges are optional.
--					debug ("test_create_sheet")
						print ("Created SpreadSheet%N")
						print (l_spreedsheet)
						print ("%N")
--					end
				end
			else
					-- Bad scope. no connection, etc
				check Unexptected_Behavior: False end
			end
		end

	test_get_sheet (an_id: attached like {EG_SHEETS_API}.spreadsheet_id)
		local
			l_esapi: EG_SHEETS_API
		do
			create l_esapi.make (last_token.token)
			if attached l_esapi.get_from_id (an_id) as l_spreedsheet_get_result then
				if l_esapi.has_error then
--					debug ("test_create_sheet")
						print ("test_create_sheet-> Error   %N" )
						print ("test_create_sheet-> Error: msg:" + l_esapi.error_message)
						print ("test_create_sheet-> See codes here: https://developers.google.com/maps-booking/reference/rest-api-v3/status_codes")
						print ("%N")
--					end
					check
						cannot_create_the_spreedsheet: False
					end
				else
					check  Json_Field_spreadsheetId: l_spreedsheet_get_result.has_substring ("spreadsheetId") end
					check  Json_Field_properties: l_spreedsheet_get_result.has_substring ("properties") end
					check  Json_Field_sheets: l_spreedsheet_get_result.has_substring ("sheets") end
					check  Json_Field_spreadsheetUrl: l_spreedsheet_get_result.has_substring ("spreadsheetUrl") end
						-- developerMetadata and namedRanges are optional.
--					debug ("test_create_sheet")
						logger.write_debug ("test_get_sheet-> success. Result:%N")
						logger.write_debug (l_spreedsheet_get_result + "%N")
						logger.write_debug ("test_get_sheet-> success. ")
--					end
				end
			else
					-- Bad scope. no connection, etc
				check Unexptected_Behavior: False end
			end
		end

	test_append_sheet (an_id: attached like {EG_SHEETS_API}.spreadsheet_id)
		local
			l_esapi: EG_SHEETS_API
			l_data: ARRAY[ARRAY[STRING]]
		do
			l_data := <<
					<<"test1", "test2">>,
					<<"test3", "test4">>
				>>
			create l_esapi.make (last_token.token)
			if attached l_esapi.append_with_id (an_id, l_data) as l_spreedsheet_get_result then
				if l_esapi.has_error then
--					debug ("test_create_sheet")
						print ("test_append_sheet-> Error   %N" )
						print ("test_append_sheet-> Error: msg:" + l_esapi.error_message)
						print ("test_append_sheet-> See codes here: https://developers.google.com/maps-booking/reference/rest-api-v3/status_codes")
						print ("%N")
--					end
					check
						cannot_create_the_spreedsheet: False
					end
				else
					check  Json_Field_spreadsheetId: l_spreedsheet_get_result.has_substring ("spreadsheetId") end
					check  Json_Field_properties: l_spreedsheet_get_result.has_substring ("properties") end
					check  Json_Field_sheets: l_spreedsheet_get_result.has_substring ("sheets") end
					check  Json_Field_spreadsheetUrl: l_spreedsheet_get_result.has_substring ("spreadsheetUrl") end
						-- developerMetadata and namedRanges are optional.
--					debug ("test_create_sheet")
						print ("test_append_sheet-> success. Result:%N")
						print (l_spreedsheet_get_result + "%N")
--					end
				end
			else
					-- Bad scope. no connection, etc
				check Unexptected_Behavior: False end
			end
		end

	test_create_sheet_json
		local
			l_esapi: EG_SHEETS_JSON
		do
			create l_esapi.make (last_token.token)
		end


feature {NONE} -- Implementations

	CREDENTIALS_PATH: STRING="credentials.json" -- get this file from https://console.developers.google.com/
			-- Credentials path to json file.
end
