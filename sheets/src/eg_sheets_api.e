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
		do
			api_post_call (sheets_url ("spreadsheets/" + a_spreadsheet_id, Void ), Void, Void)
			check
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				parse_last_response
				Result := l_body
			end
		end

feature -- Parameters Factory

	parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
		local
			l_result: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			l_tuple : detachable TUPLE [name: STRING; value: STRING]
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
				if attached l_response.body as l_body then
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
			if attached l_access_token as ll_access_token then
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
					request.add_header ("Content-Type", l_upload_data.content_type)
					request.set_upload_filename (l_upload_data.file_name.absolute_path.name)
					request.add_form_parameter("source", l_upload_data.file_name.name.as_string_32)
				end
			end
		end

feature -- Service Endpoint

	endpooint_sheets_url: STRING  = "https://sheets.googleapis.com"
			--  base URL that specifies the network address of an API service.
end

