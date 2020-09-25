note
	description: "Common abstraction to access (read/write Google API data)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_COMMON_API

inherit

	LOGGABLE

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
			-- Google API version.

	scopes: LIST [STRING_8]
			--Lists of Authorization Scopes.

feature -- Scopes

	add_scope (a_scope: STRING_8)
			-- Add an scope `a_scope` to the list of scopes.
		do
			scopes.force (a_scope)
		end

	clear_scopes
			-- Remove all items.
		do
			scopes.wipe_out
		ensure
			scopes.is_empty
		end

feature -- Query Parameters Factory

	query_parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			-- @JV please add a call example
		local
			l_result: like query_parameters
			l_tuple : like query_parameters.item
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

feature {NONE} -- Implementation

	api_post_call (a_api_url: STRING; a_query_params: detachable STRING_TABLE [STRING]; a_payload: detachable STRING; a_upload_data: detachable TUPLE[data:PATH; content_type: STRING])
		note
			eis: "name=payload_body", "src=https://tools.ietf.org/html/draft-ietf-httpbis-p3-payload-14#section-3.2", "protocol=https://tools.ietf.org/html/draft-ietf-httpbis-p3-payload-14#section-3.2"
			-- POST REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "POST", a_query_params, a_payload, a_upload_data)
		end

	api_delete_call (a_api_url: STRING; a_query_params: detachable STRING_TABLE [STRING])
			-- DELETE REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "DELETE", a_query_params, Void, Void)
		end

	api_get_call (a_api_url: STRING; a_query_params: detachable STRING_TABLE [STRING])
			-- GET REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "GET", a_query_params, Void, Void)
		end

	internal_api_call (a_api_url: STRING; a_method: STRING; a_query_params: detachable STRING_TABLE [STRING]; a_payload: detachable STRING; a_upload_data: detachable TUPLE[filename:PATH; content_type: STRING])
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
				-- TODO add a class with the valid scopes.
			create config.make_default ("", "")

				-- Add scopes
			if scopes.is_empty then
				-- Don't add scopes if the list is empty.	
			else
				config.set_scope (build_scope)
			end

				-- Initialization

			create api_service.make (create {OAUTH_20_GOOGLE_API}, config)
				--| TODO improve cypress service creation procedure to make configuration optional.

				--| TODO rewrite prints as logs
			logger.write_debug ("%N===Google  OAuth Workflow using OAuth access token for the owner of the application ===%N")

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
					-- https://tools.ietf.org/html/rfc7231#section-6.5.10
					--
					--
					-- https://tools.ietf.org/html/rfc7230#section-3.3.2
					--
				upload_data (a_method, request, a_upload_data)
				add_parameters (a_method, request, a_query_params)
				-- adding payload
				if attached a_payload then
					request.add_header ("Content-length", a_payload.count.out)
					request.add_header ("Content-Type", "application/json; charset=UTF-8")
					request.add_payload (a_payload)
				else
					request.add_header ("Content-length", "0")
				end

				api_service.sign_request (ll_access_token, request)

				logger.write_debug ("internal_api_call->uri:'" + request.uri + "'")
				if attached request.upload_file as l_s then
					logger.write_debug ("internal_api_call->upload file:'" + l_s.out + "'")
				end
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					last_response := l_response
				end
			end
			last_api_call := a_api_url.string
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

	add_parameters (a_method: STRING; request: OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
			-- add parameters 'a_params' (with key, value) to the oauth request 'request'.
			--| at the moment all params are added to the query_string.
		do
				--| TODO check if we need to call add_body_parameters if the method is PUT or POST			
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
					logger.write_debug ("upload_data-> upload file name: '" + l_upload_data.file_name.absolute_path.name.out + "'")
					request.add_header ("Content-Type", l_upload_data.content_type)
					request.set_upload_filename (l_upload_data.file_name.absolute_path.name)
					request.add_form_parameter("source", l_upload_data.file_name.name.as_string_32)
				end
			end
		end


	build_scope: STRING
			-- Create an string as list of space- delimited, case-sensitive strings.
			-- https://tools.ietf.org/html/rfc6749#section-3.3
		do
			if scopes.is_empty then
				Result := ""
			else
				Result := ""
				across scopes as ic loop
					Result.append (ic.item)
					Result.append_character (' ')
				end
				Result.adjust
			end
		end

feature -- Service Endpoint

	endpoint_url: STRING
			-- base URL that specifies the network address of an API service.
		deferred
		end

end

