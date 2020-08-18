note
	description: "Sheets API: specify how to read and write Google Sheets data."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SHEETS_API

inherit
	LOGGABLE

create
	make

feature {NONE} -- Initialization

	make (a_access_token: READABLE_STRING_32)
		do
			default_create
				-- Using a code verifier
			access_token := a_access_token
			enable_version_4
		end

feature -- Reset

	reset
		do
			create access_token.make_empty
		end

feature -- Access

	access_token: STRING_32
			-- Google OAuth2 access token.

	http_status: INTEGER
		-- Contains the last HTTP status code returned.

	last_api_call: detachable STRING
		-- Contains the last API call.

	last_response: detachable OAUTH_RESPONSE
		-- Cointains the last API response.

	version: STRING_8
			-- Google Sheets version

	spreadsheet_id: detachable STRING


feature -- Spreedsheets Operations

	create_spreedsheet: detachable STRING
			-- POST /spreadsheets
		note
			EIS:"name=create.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/create", "protocol=uri"
		do
			api_post_call (sheets_url ("spreadsheets", Void ), Void, Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				parse_last_response
				Result := l_body
			end
		end

	get_from_id (a_spreadsheet_id: attached like spreadsheet_id): detachable like last_response.body
			-- POST /spreadsheets/`a_spreadsheet_id'
		note
			EIS:"name=get.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/get", "protocol=uri"
		require
			not a_spreadsheet_id.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			l_qry_params: STRING_TABLE [STRING]
		do

			logger.write_information ("get_from_id-> Now getting sheet from id:" + a_spreadsheet_id)
			create l_qry_params.make (2)
			l_qry_params.extend ("true", "includeGridData") -- all content
--			l_params.extend ("sheets.properties", "fields") -- properties only

			api_get_call (sheets_url ("spreadsheets/" + a_spreadsheet_id, Void), l_qry_params)
			check
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				parse_last_response
				if l_response.status = {HTTP_STATUS_CODE}.ok then
					Result := l_body

					create l_file.make_create_read_write ("/tmp/hitme_sheet_json-get_from_id.json")
					logger.write_information ("get_from_id->Writing body into " + l_file.path.utf_8_name)
					l_file.close
					l_file.wipe_out
					l_file.open_append

					l_file.put_string (l_body)
					l_file.close
				elseif l_response.status = {HTTP_STATUS_CODE}.not_found then
					logger.write_error ("get_from_id-> Not found:" + l_response.status.out + " %NBody: " + l_body)
				else
					logger.write_error ("get_from_id-> Status code invalid:" + l_response.status.out + " %NBody: " + l_body)
				end
			end
		end

	append_with_id (a_spreadsheet_id: attached like spreadsheet_id; a_data: detachable ARRAY[ARRAY[STRING]]): detachable like last_response.body
		note
			EIS:"name=append.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append", "protocol=uri"
		require
			not a_spreadsheet_id.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			l_range,
			l_path_params_s: STRING
			l_qry_params: STRING_TABLE [STRING]
			l_post_data: TUPLE[data:PATH; content_type: STRING]
		do
			l_range := ""
			logger.write_information ("append-> spreadsheed_id:" + a_spreadsheet_id)
			-- path params
			l_path_params_s := a_spreadsheet_id
			l_path_params_s.append ("/values/") -- spreadsheets/{spreadsheetId}/values/{range}:append

			l_path_params_s.append ("Sheet1!A:A") -- range ex. A1:B2 or namedRanges TRY: Sheet1!A:A | last not null index could be: =index(J:J,max(row(J:J)*(J:J<>"")))

			l_path_params_s.append (":append")
			-- qry params
			create l_qry_params.make (2)
			l_qry_params.extend ("RAW", "valueInputOption") -- INPUT_VALUE_OPTION_UNSPECIFIED|RAW|USER_ENTERED https://developers.google.com/sheets/api/reference/rest/v4/ValueInputOption
			l_qry_params.extend ("INSERT_ROWS", "insertDataOption") -- OVERWRITE|INSERT_ROWS https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append#InsertDataOption
			l_qry_params.extend ("true", "includeValuesInResponse") -- BOOLEAN
			l_qry_params.extend ("UNFORMATTED_VALUE", "responseValueRenderOption") -- UNFORMATTED_VALUE|FORMULA|FORMATTED_VALUE https://developers.google.com/sheets/api/reference/rest/v4/ValueRenderOption
			l_qry_params.extend ("SERIAL_NUMBER", "responseDateTimeRenderOption") -- SERIAL_NUMBER|FORMATTED_STRING https://developers.google.com/sheets/api/reference/rest/v4/DateTimeRenderOption

			l_post_data := impl_append_post_data

			api_post_call (sheets_url ("spreadsheets/" + l_path_params_s, Void), l_qry_params, l_post_data)
			check
				attached last_response as l_response
				attached l_response.body as l_body
				attached data_file as l_data_file
			then
				parse_last_response
				if l_response.status = {HTTP_STATUS_CODE}.ok then
					Result := l_body

					create l_file.make_create_read_write ("/tmp/hitme_sheet_json-append.json")
					logger.write_information ("get_from_id->Writing body into " + l_file.path.utf_8_name)
					l_file.close
					l_file.wipe_out
					l_file.open_append

					l_file.put_string (l_body)
					l_file.close
				elseif l_response.status = {HTTP_STATUS_CODE}.not_found then
					logger.write_error ("get_from_id-> Not found:" + l_response.status.out + " %NBody: " + l_body)
				else
					logger.write_error ("get_from_id-> Status code invalid:" + l_response.status.out + " %NBody: " + l_body)
				end
			end
		end

feature -- Parameters Factory

	parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			-- @JV please add a call example
		local
			l_result: like parameters
			l_tuple : like parameters.item
			i: INTEGER
		do
			if attached a_params then
				i := 1
				create l_result.make_filled (Void, 1, a_params.count)
				across a_params as ic
				loop
					create l_tuple.default_create
					l_tuple.put (ic.key, 1)
					l_tuple.put (ic.item, 2)
					l_result.force (l_tuple, i)
					i := i + 1
				end
				Result := l_result
			end
		end


feature -- Error Report

	parse_last_response
		require
			attached last_response
		local
			l_json_parser: JSON_PARSER
		do
			check
				attached last_response as l_response
			then
				if l_response.status = {HTTP_STATUS_CODE}.unauthorized then
					logger.write_error ("parse_last_response->Unauthorized status, review your authorization credentials")
				end
				if attached l_response.body as l_body then
					logger.write_debug ("parse_last_response->body:" + l_body)
					create l_json_parser.make_with_string (l_body)
					l_json_parser.parse_content
					if l_json_parser.is_valid then
						if attached {JSON_OBJECT} l_json_parser.parsed_json_value as l_main_jso then
							if attached {JSON_OBJECT} l_main_jso.item ("error") as l_error_jso then
								if attached {JSON_NUMBER} l_error_jso.item ("code") as l_jso then
									print ("parse_last_response-> error code:" + l_jso.representation + "%N")
								end
								if attached {JSON_STRING} l_error_jso.item ("message") as l_jso then
									print ("parse_last_response-> error message:" + l_jso.unescaped_string_8 + "%N")
								end
								if attached {JSON_STRING} l_error_jso.item ("status") as l_jso then
									print ("parse_last_response-> error status:" + l_jso.unescaped_string_8 + "%N")
								end
							end
						end
					else
						print ("parse_last_response-> Error: Invalid json body content:" + l_body + "%N")
					end
				end
			end
		end

	has_error: BOOLEAN
			-- Last api call raise an error?
		do
			if attached last_response as l_response then
				Result := l_response.status /= 200
			else
				Result := False
			end
		end

	error_message: STRING
			-- Last api call error message.
		require
			has_error: has_error
		do
			if
				attached last_response as l_response
			then
				if
					attached l_response.error_message as l_error_message
				then
					Result := l_error_message
				else
					Result := l_response.status.out
				end
			else
				Result := "Unknown Error"
			end
		end

feature -- Versions

	enable_version_4
			-- Enable Google sheets version v4.
		do
			version := "v4"
		ensure
			version_set: version.same_string ("v4")
		end

feature {NONE} -- Implementation

	api_post_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING]; a_upload_data: detachable TUPLE[data:PATH; content_type: STRING])
			-- POST REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "POST", a_params, a_upload_data)
		end

	api_delete_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- DELETE REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "DELETE", a_params, Void)
		end

	api_get_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- GET REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "GET", a_params, Void)
		end

	internal_api_call (a_api_url: STRING; a_method: STRING; a_params: detachable STRING_TABLE [STRING]; a_upload_data: detachable TUPLE[filename:PATH; content_type: STRING])
		note
			EIS:"name=access token", "src=https://developers.google.com/identity/protocols/oauth2", "protocol=uri"
		local
			request: OAUTH_REQUEST
			l_access_token: detachable OAUTH_TOKEN
			api_service: OAUTH_20_SERVICE
			config: OAUTH_CONFIG
		do
			logger.write_debug ("internal_api_call-> a_api_url:" + a_api_url + " method:" + a_method)
				-- TODO improve this, so we can check the required scopes before we
				-- do an api call.
			create config.make_default ("", "")
			config.set_scope ("https://www.googleapis.com/auth/spreadsheets")

				-- Initialization

			create api_service.make (create {OAUTH_20_GOOGLE_API}, config)
				--| TODO improve cypress service creation procedure to make configuration optional.

			print ("%N===Google  OAuth Workflow using OAuth access token for the owner of the application ===%N")
				--| TODO rewrite prints as logs

				-- Create the access token that will identifies the user making the request.
			create l_access_token.make_token_secret (access_token, "NOT_NEEDED")
				--| Todo improve access_token to create a token without a secret.
			check attached l_access_token as ll_access_token then
				logger.write_information ("internal_api_call->Got the Access Token:" + ll_access_token.token);

					--Now let's go and check if the request is signed correcty
				logger.write_information ("internal_api_call->Now we're going to verify our credentials...%N");
					-- Build the request and authorize it with OAuth.
				create request.make (a_method, a_api_url)
					-- Workaorund to make it work with Google API
					-- in other case it return HTTP 411 Length Required.
					-- Todo check.
				request.add_header ("Content-length", "0")
				upload_data (a_method, request, a_upload_data)
				add_parameters (a_method, request, a_params)

				api_service.sign_request (ll_access_token, request)

				logger.write_debug ("internal_api_call->uri:'" + request.uri + "'")
				if attached request.upload_file as l_s then
					logger.write_debug ("internal_api_call->upload file:'" + l_s + "'")
				end
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					last_response := l_response
				end
			end
			last_api_call := a_api_url.string
		end

	sheets_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Sheet url endpoint
		note
			eis: "name=Sheets service endpoint", "src=https://developers.google.com/sheets/api/reference/rest", "protocol=uri"
		require
			a_query_attached: a_query /= Void
		do
			create 	Result.make_from_string (endpooint_sheets_url)
			Result.append ("/")
			Result.append (version)
			Result.append ("/")
			Result.append (a_query)
			if attached a_params then
				Result.append_character ('?')
				Result.append (a_params)
			end
		ensure
			Result_attached: Result /= Void
		end

	url (a_base_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]): STRING
			-- url for `a_base_url' and `a_parameters'
		require
			a_base_url_attached: a_base_url /= Void
		do
			create Result.make_from_string (a_base_url)
			append_parameters_to_url (Result, a_parameters)
		end

	append_parameters_to_url (a_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]])
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			i: INTEGER
			l_first_param: BOOLEAN
		do
			if a_parameters /= Void and then a_parameters.count > 0 then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end
				from
					i := a_parameters.lower
				until
					i > a_parameters.upper
				loop
					if attached a_parameters[i] as a_param then
						if l_first_param then
							a_url.append_character ('?')
						else
							a_url.append_character ('&')
						end
						a_url.append_string (a_param.name)
						a_url.append_character ('=')
						a_url.append_string (a_param.value)
						l_first_param := False
					end
					i := i + 1
				end
			end
		end

	add_parameters (a_method: STRING; request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
			-- add parameters 'a_params' (with key, value) to the oauth request 'request'.
			--| at the moment all params are added to the query_string.
		do
			add_query_parameters (request, a_params)
		end

	add_query_parameters (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_query_string_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

	add_body_parameters (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_body_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

	upload_data (a_method: STRING; request:OAUTH_REQUEST; a_upload_data: detachable TUPLE[file_name:PATH; content_type: STRING])
		local
			l_raw_file: RAW_FILE
		do
			if a_method.is_case_insensitive_equal_general ("POST") and then attached a_upload_data as l_upload_data then
				create l_raw_file.make_open_read (l_upload_data.file_name.absolute_path.name)
				if l_raw_file.exists then
					logger.write_debug ("upload_data-> Content-type: '" + l_upload_data.content_type + "'")
					logger.write_debug ("upload_data-> upload file name: '" + l_upload_data.file_name.absolute_path.name + "'")
					request.add_header ("Content-Type", l_upload_data.content_type)
					request.set_upload_filename (l_upload_data.file_name.absolute_path.name)
					request.add_form_parameter("source", l_upload_data.file_name.name.as_string_32)
				end
			end
		end

feature -- Service Endpoint

	endpooint_sheets_url: STRING  = "https://sheets.googleapis.com"
			--  base URL that specifies the network address of an API service.

feature {NONE} -- Implementation

	data_file: detachable PLAIN_TEXT_FILE


	impl_append_post_data: TUPLE[data:PATH; content_type: STRING]
		require
			not attached data_file
		local
			l_res: JSON_OBJECT
			l_jsa_main,
			l_jsa_line: JSON_ARRAY

		do
			create l_res.make_with_capacity (5)
			l_res.put_string ("ROWS", "majorDimension") -- "DIMENSION_UNSPECIFIED", "ROWS", "COLUMNS"

			create l_jsa_main.make (10)

			create l_jsa_line.make (2)
			l_jsa_line.extend (create {JSON_STRING}.make_from_string ("first_cell line 1"))
			l_jsa_line.extend (create {JSON_STRING}.make_from_string ("second_cell line 1"))
			l_jsa_main.extend (l_jsa_line)

			l_res.put (l_jsa_main, "values")


			create data_file.make_open_temporary
			check
				attached data_file as l_df
			then
				l_df.put_string (l_res.representation)
				Result := [l_df.path, "application/json"]
			end


--			Result.content_type :=


			logger.write_debug ("impl_append_body-> Result: '" + Result.out + "'")
		ensure
			attached data_file
		end

end

