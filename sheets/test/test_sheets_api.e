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
			set_from_json_credentials_file_path (create {PATH}.make_from_string ("/home/pg/tmp/eg-sheets/eg-sheets_credentials_eg-suite-desktop-api.json"))
			retrieve_access_token
			test_create_sheet
		end


feature -- Tests

	test_create_sheet
		local
			esapi: EG_SHEETS_API
		do
			create esapi.make (last_token.token)
			if attached esapi.create_spreedsheet as l_spreedsheet then
				if esapi.has_error then
--					debug ("test_create_sheet")
						print ("Error:  test_create_sheet %N" )
						print ("Error: " + esapi.error_message)
						print ("%N")
--					end
					check  cannot_create_the_spreedsheet: False end
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

	test_create_sheet_json
		local
			esapi: EG_SHEETS_JSON
		do
			create esapi.make (last_token.token)
		end

end
