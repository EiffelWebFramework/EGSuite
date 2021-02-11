note
	description: "Sheets API: specify how to read and write Google Sheets data."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SHEETS_API

inherit

	EG_COMMON_API
		rename
			endpoint_url as endpoint_sheets_url
		end

create
	make

feature {NONE} -- Initialization

	make (a_access_token: READABLE_STRING_32)
		do
				-- Using a code verifier
			access_token := a_access_token
			enable_version_4
			default_scope
		end

	default_scope
		do
			create {ARRAYED_LIST [STRING_8]} scopes.make (5)
			add_scope ("https://www.googleapis.com/auth/spreadsheets")
		end

feature -- Spreedsheets

	spreadsheet_id: detachable STRING


feature -- Spreedsheets Operations

	create_spreedsheet: detachable STRING
			-- POST /spreadsheets
		note
			EIS:"name=create.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/create", "protocol=uri"
		do
			api_post_call (sheets_url ("spreadsheets", Void ), Void, Void, Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
	end

	get_from_id (a_spreadsheet_id: attached like spreadsheet_id; a_params: detachable EG_SPREADSHEET_PARAMETERS): detachable like last_response.body
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

			api_get_call (sheets_url ("spreadsheets/" + a_spreadsheet_id, Void), a_params)
			check
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				parse_last_response
				if l_response.status = {HTTP_STATUS_CODE}.ok then
					Result := l_body

					debug
						create l_file.make_create_read_write ("/tmp/hitme_sheet_json-get_from_id.json")
						logger.write_information ("get_from_id->Writing body into " + l_file.path.utf_8_name)
						l_file.close
						l_file.wipe_out
						l_file.open_append

						l_file.put_string (l_body)
						l_file.close
					end
				elseif l_response.status = {HTTP_STATUS_CODE}.not_found then
					logger.write_error ("get_from_id-> Not found:" + l_response.status.out + " %NBody: " + l_body)
				else
					logger.write_error ("get_from_id-> Status code invalid:" + l_response.status.out + " %NBody: " + l_body)
				end
			end
		end


	get_from_id2 (a_spreadsheet_id: attached like spreadsheet_id): detachable like last_response.body
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

	append_with_id_raw (a_spreadsheet_id: attached like spreadsheet_id; a_range, a_raw_data: STRING): detachable like last_response.body
		note
			EIS:"name=append.spreedsheets", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append", "protocol=uri"
		require
			not a_spreadsheet_id.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			l_range,
			l_path_params_s: STRING
			l_qry_params: STRING_TABLE [STRING]
			l_post_data: STRING -- TUPLE[data:PATH; content_type: STRING]
			url_encoder: URL_ENCODER
		do
			l_range := ""
			logger.write_information ("append_with_id_raw-> spreadsheed_id:" + a_spreadsheet_id)
			-- path params
			l_path_params_s := a_spreadsheet_id
			l_path_params_s.append ("/values/") -- spreadsheets/{spreadsheetId}/values/{range}:append

				-- TODO add url encode to the query parameters.
			create url_encoder
			l_path_params_s.append (url_encoder.encoded_string (a_range)) -- range ex. A1:B2 or namedRanges TRY: Sheet1!A:A | last not null index could be: =index(J:J,max(row(J:J)*(J:J<>"")))

			l_path_params_s.append (":append")
			-- qry params
			create l_qry_params.make (2)
			l_qry_params.extend ("RAW", "valueInputOption") -- INPUT_VALUE_OPTION_UNSPECIFIED|RAW|USER_ENTERED https://developers.google.com/sheets/api/reference/rest/v4/ValueInputOption
--			l_qry_params.extend ("INSERT_ROWS", "insertDataOption") -- OVERWRITE|INSERT_ROWS https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.values/append#InsertDataOption
--			l_qry_params.extend ("true", "includeValuesInResponse") -- BOOLEAN
--			l_qry_params.extend ("json", "alt") -- BOOLEAN
--			alt=json
--			l_qry_params.extend ("UNFORMATTED_VALUE", "responseValueRenderOption") -- UNFORMATTED_VALUE|FORMULA|FORMATTED_VALUE https://developers.google.com/sheets/api/reference/rest/v4/ValueRenderOption
--			l_qry_params.extend ("SERIAL_NUMBER", "responseDateTimeRenderOption") -- SERIAL_NUMBER|FORMATTED_STRING https://developers.google.com/sheets/api/reference/rest/v4/DateTimeRenderOption


			l_post_data := a_raw_data
			logger.write_debug ("append_with_id_raw -> post data are:" + l_post_data + "-----")

				-- Google API append require body parameter instead of upload data.
			api_post_call (sheets_url ("spreadsheets/" + l_path_params_s, Void), l_qry_params, l_post_data, Void)

			check
				attached last_response as l_response
				attached l_response.body as l_body
			then
				parse_last_response
				if l_response.status = {HTTP_STATUS_CODE}.ok then
					Result := l_body

--					create l_file.make_create_read_write ("/tmp/hitme_sheet_json-append.json")
--					logger.write_information ("get_from_id->Writing body into " + l_file.path.utf_8_name)
--					l_file.close
--					l_file.wipe_out
--					l_file.open_append

--					l_file.put_string (l_body)
--					l_file.close
				elseif l_response.status = {HTTP_STATUS_CODE}.not_found then
					logger.write_error ("append_with_id_raw-> Not found:" + l_response.status.out + " %NBody: " + l_body)
				else
					logger.write_error ("append_with_id_raw-> Status code invalid:" + l_response.status.out + " %NBody: " + l_body)
				end
			end
		end

feature -- SpreedSheet URL

	sheets_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Sheet url endpoint
		note
			eis: "name=Sheets service endpoint", "src=https://developers.google.com/sheets/api/reference/rest", "protocol=uri"
		require
			a_query_attached: a_query /= Void
		do
			create 	Result.make_from_string (endpoint_sheets_url)
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

feature -- Versions

	enable_version_4
			-- Enable Google sheets version v4.
		do
			version := "v4"
		ensure
			version_set: version.same_string ("v4")
		end


feature -- Service Endpoint

	endpoint_sheets_url: STRING
			-- <Precursor>
		do
			Result := "https://sheets.googleapis.com"
		end

feature {NONE} -- Implementation

	data_file: detachable PLAIN_TEXT_FILE


	impl_append_post_data_sample_2: TUPLE[data:PATH; content_type: STRING]
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

