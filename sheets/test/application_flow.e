note
	description: "test application root class"
	date: "$Date: 2018-11-16 10:29:33 -0300 (Fri, 16 Nov 2018) $"
	revision: "$Revision: 102478 $"

deferred class
	APPLICATION_FLOW

inherit
	ARGUMENTS


feature {NONE} -- Initialization

	retrieve_access_token
			-- get the access token
		local
			l_secs: INTEGER
		do
			create last_token.make_empty
			get_token
			if last_token.token.is_empty then
				debug
					print ("There is something wwrong")
				end
			else
				debug
					print ("Let's play with the API")
				end
			end
		end

	get_token
		local
			file: FILE
			token: OAUTH_TOKEN
			l_date_file: DATE_TIME
			l_date_now: DATE_TIME
			l_diff:  INTEGER_64
		do

			create {PLAIN_TEXT_FILE} file.make_with_name ("token.access")
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				create l_date_file.make_from_epoch (file.date)
				create l_date_now.make_now_utc
				l_diff := l_date_now.definite_duration (l_date_file).seconds_count
				if attached {OAUTH_TOKEN} deserialize (file.last_string) as l_token then
					token := l_token
					if l_diff > l_token.expires_in then
						token := refresh_access_token (l_token)
					end
				else
					create token.make_empty
				end
				file.close
			else
				token := get_token_from_url

			end
			last_token := token
		end

	get_token_from_url: OAUTH_TOKEN
		require
			attached api_key
			attached api_secret
		local
			google: OAUTH_20_GOOGLE_API
			config: OAUTH_CONFIG
			api_service: OAUTH_SERVICE_I
			file: FILE
		do

			check
				attached api_key as l_api_key
				attached api_secret as l_api_secret
			then
				print ("get_token_from_url-> api_key:'" + l_api_key + "' secret:'" + l_api_secret + "'" )
				create Result.make_empty
				create config.make_default (l_api_key, l_api_secret)
					config.set_callback ("urn:ietf:wg:oauth:2.0:oob")
				config.set_scope ("https://www.googleapis.com/auth/spreadsheets")
				create google
				api_service := google.create_service (config)
				print ("%N===Google OAuth Workflow ===%N")

					-- Obtain the Authorization URL
				print ("%NFetching the Authorization URL...");
				if attached api_service.authorization_url (empty_token) as lauthorization_url then
					print ("%NGot the Authorization URL!%N");
					print ("%NNow go and authorize here:%N");
					print (lauthorization_url);
					print ("%NAnd paste the authorization code here%N");
					io.read_line
				end

				if attached api_service.access_token_post (empty_token, create {OAUTH_VERIFIER}.make (io.last_string)) as access_token then
					create {PLAIN_TEXT_FILE} file.make_create_read_write ("token.access")
					file.put_string (serialize (access_token))
					Result := access_token
					file.flush
					file.close
				end
			end
		end

	refresh_access_token (a_token: OAUTH_TOKEN): OAUTH_TOKEN
			-- https://developers.google.com/identity/protocols/oauth2/limited-input-device#offline
				--client_id=your_client_id&
				--client_secret=your_client_secret&
				--refresh_token=refresh_token&
				--grant_type=refresh_token
		require
			attached api_key
			attached api_secret
		local
			google: OAUTH_20_GOOGLE_API
			config: OAUTH_CONFIG
			request: OAUTH_REQUEST
			file: FILE
			api: OAUTH_20_API
		do
			check
				attached api_key as l_api_key
				attached api_secret as l_api_secret
			then
				print ("refresh_access_token-> api_key:'" + l_api_key + "' secret:'" + l_api_secret + "'" )
				create Result.make_empty
				create google
				create request.make ("POST", google.access_token_endpoint )
				request.add_body_parameter ("client_id", l_api_key)
				request.add_body_parameter ("client_secret", l_api_secret)
				request.add_body_parameter ("refresh_token", if attached a_token.refresh_token as l_token then l_token else "" end)
				request.add_body_parameter ("grant_type", "refresh_token")
				if attached request.execute as l_response then
					if attached l_response.body as l_body then
						if attached {OAUTH_TOKEN} google.access_token_extractor.extract (l_body) as l_access_token then
							create {PLAIN_TEXT_FILE} file.make_create_read_write ("token.access")
							file.put_string (serialize (l_access_token))
							Result := l_access_token
							file.flush
							file.close
						end
					end
				end
			end
		end

feature -- Status Setting

	set_from_json_credentials_file_path (an_fp: PATH)
			-- sets api_key and api_secret from given api credentials file path normally provided by google -> https://console.developers.google.com
			-- create a Create OAuth client ID -> desktop app -> and export it to a json file with download link
		local
			l_json_parser: JSON_PARSER
			l_ut: FILE_UTILITIES
		do
			check
				l_ut.file_exists (an_fp.utf_8_name)
				could_read_json_credentials_file: attached (create {JSON_FILE_READER}).read_json_from (an_fp.utf_8_name) as l_json_file_content
			then
				create l_json_parser.make_with_string (l_json_file_content)
				l_json_parser.parse_content
				check
					valid_json_file_content: l_json_parser.is_valid
				then
					check
						valid_main_object: attached {JSON_OBJECT} l_json_parser.parsed_json_value as l_main_json_o
					then
						check
							valid_installed: attached {JSON_OBJECT} l_main_json_o.item ("installed") as l_installed_jso
						then
							check
								has_client_id: attached {JSON_STRING} l_installed_jso.item ("client_id") as l_client_id_js_s
							then
								api_key := l_client_id_js_s.unescaped_string_8
							end

							check
								has_client_secret: attached {JSON_STRING} l_installed_jso.item ("client_secret") as l_client_secret_js_s
							then
								api_secret := l_client_secret_js_s.unescaped_string_8
							end
						end
					end
				end
			end
		end

feature -- Serialize Access Token

	serialize (a_object: ANY): STRING
			-- Serialize `a_object'.
		require
			a_object_not_void: a_object /= Void
		local
			l_sed_rw: SED_MEMORY_READER_WRITER
			l_sed_ser: SED_INDEPENDENT_SERIALIZER
			l_cstring: C_STRING
			l_cnt: INTEGER
		do
			create l_sed_rw.make
			l_sed_rw.set_for_writing
			create l_sed_ser.make (l_sed_rw)
			l_sed_ser.set_root_object (a_object)
			l_sed_ser.encode
				-- the `count' gives us the number of bytes
				-- we have to read and put into the string.
			l_cnt := l_sed_rw.count
			create l_cstring.make_by_pointer_and_count (l_sed_rw.buffer.item, l_cnt)
			Result := l_cstring.substring (1, l_cnt)
		ensure
			serialize_not_void: Result /= Void
		end

feature -- Deserialize Access Token

	deserialize (a_string: STRING): detachable ANY
			-- Deserialize `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			l_sed_rw: SED_MEMORY_READER_WRITER
			l_sed_ser: SED_INDEPENDENT_DESERIALIZER
			l_cstring: C_STRING
		do
			create l_cstring.make (a_string)
			create l_sed_rw.make_with_buffer (l_cstring.managed_data)
			l_sed_rw.set_for_reading
			create l_sed_ser.make (l_sed_rw)
			l_sed_ser.decode (True)
			Result := l_sed_ser.last_decoded_object
		end

feature -- Token

	last_token: OAUTH_TOKEN
			-- Last retrived token

feature {NONE} -- Implementation

	api_key: detachable STRING
	api_secret: detachable STRING
	empty_token: detachable OAUTH_TOKEN

	
end
