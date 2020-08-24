note
	description: "[
		Object representing an SpreadSheet Resource
		
		{
		  "spreadsheetId": string,
		  "properties": {
		    object (SpreadsheetProperties)
		  },
		  "sheets": [
		    {
		      object (Sheet)
		    }
		  ],
		  "namedRanges": [
		    {
		      object (NamedRange)
		    }
		  ],
		  "spreadsheetUrl": string,
		  "developerMetadata": [
		    {
		      object (DeveloperMetadata)
		    }
		  ]
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Resource that represents a spreadsheet.", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#Spreadsheet", "protocol=uri"

class
	EG_SPREADSHEET

feature -- Access

	id: detachable IMMUTABLE_STRING_8
			-- The ID of the spreadsheet. This field is read-only.

	properties: detachable EG_SPREADSHEET_PROPERTIES
			-- Overall properties of a spreadsheet.

	sheets: detachable LIST [EG_SHEET]
			-- The sheets that are part of a spreadsheet.

	named_ranges: detachable LIST [EG_NAMED_RANGE]
			-- The named ranges defined in a spreadsheet.

	url: detachable IMMUTABLE_STRING_8
			-- The url of the spreadsheet. This field is read-only.

	developer_metadata: detachable LIST [EG_DEVELOPER_METADATA]
			-- The developer metadata associated with a spreadsheet.


feature -- Status Report

	is_id_set: BOOLEAN
			-- Has the id been setted?

	is_url_set: BOOLEAN
			-- Has the url been setted?		

feature -- Change Element

	set_protperty (a_properties: like properties)
			-- Set properties with `a_properties`.
		do
			properties := a_properties
		ensure
			properties_set: properties = a_properties
		end

	force_sheet (a_sheet: EG_SHEET)
			-- Add a sheet `a_sheet` to the list of sheets.
		local
			l_sheets: like sheets
		do
			l_sheets := sheets
			if l_sheets /= Void then
				l_sheets.force (a_sheet)
			else
				create {ARRAYED_LIST [EG_SHEET]} l_sheets.make (2)
				l_sheets.force (a_sheet)
			end
			sheets := l_sheets
		end

	set_sheets (a_sheets: like sheets)
			-- Set the list of `sheets` with `a_sheets`.
		do
			sheets := a_sheets
		ensure
			sheets_set: sheets = a_sheets
		end

	force_name_range (a_range: EG_NAMED_RANGE)
			-- Add a range `a_range` to the list of ranges.
		local
			l_named_ranges: like named_ranges
		do
			l_named_ranges := named_ranges
			if l_named_ranges /= Void then
				l_named_ranges.force (a_range)
			else
				create {ARRAYED_LIST [EG_NAMED_RANGE]} l_named_ranges.make (2)
				l_named_ranges.force (a_range)
			end
			named_ranges := l_named_ranges
		end

	set_named_ranges (a_named_ranges: like named_ranges)
			-- Set the list `named_ranges` with `a_named_ranges`.
		do
			named_ranges := a_named_ranges
		ensure
			named_ranges_set: named_ranges = a_named_ranges
		end

	force_developer_metadata (a_metadata: EG_DEVELOPER_METADATA)
			-- Set developer metadata `a_metadata` to metadata.
		local
			l_developer_metadata: like developer_metadata
		do
			l_developer_metadata := developer_metadata
			if l_developer_metadata /= Void then
				l_developer_metadata.force (a_metadata)
			else
				create {ARRAYED_LIST [EG_DEVELOPER_METADATA]} l_developer_metadata.make (2)
				l_developer_metadata.force (a_metadata)
			end
			developer_metadata := l_developer_metadata
		end

	set_developer_metadata (a_metadata: like developer_metadata)
			-- Set the list `developer_metadata` with `a_metadata`.
		do
			developer_metadata := a_metadata
		ensure
			developer_metadata_set: developer_metadata = a_metadata
		end

feature {EG_SHEETS_JSON} -- Factory

	set_id (a_id: STRING)
			-- Set id with `a_id`.
		require
			no_id_set: not is_id_set
		do
			is_id_set := True
			create id.make_from_string (a_id)
		ensure
			is_id_set: is_id_set
			id_set: attached id as l_id and then l_id.is_case_insensitive_equal (a_id)
		end

	set_url (a_url: STRING)
			-- Set url with `a_url`
		require
			not_url_set: not is_url_set
		do
			is_url_set := True
			create url.make_from_string (a_url)
		ensure
			url_set: attached url as l_url and then l_url.is_case_insensitive_equal (a_url)
			is_url_set: is_url_set
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of the Current object.
		local
			l_array: JSON_ARRAY
		do
			create Result.make_with_capacity (2)
			if attached id as l_id then
				Result.put (create {JSON_STRING}.make_from_string (l_id), "spreadsheetId")
			end
			if attached properties as l_properties then
				Result.put (l_properties.to_json, "properties")
			end
			if attached sheets as l_sheets then
				create l_array.make (l_sheets.count)
				across l_sheets as ic loop
					l_array.add (ic.item.to_json)
				end
				Result.put (l_array, "sheets")
			end
			if attached named_ranges as l_named_ranges then
				create l_array.make (l_named_ranges.count)
				across l_named_ranges as ic loop
					l_array.add (ic.item.to_json)
				end
				Result.put (l_array, "namedRanges")
			end
			if attached url as l_url then
				Result.put (create {JSON_STRING}.make_from_string (l_url), "spreadsheetUrl")
			end
			if attached developer_metadata as l_developer_metadata then
				create l_array.make (l_developer_metadata.count)
				across l_developer_metadata as ic loop
					l_array.add (ic.item.to_json)
				end
				Result.put (l_array, "developerMetadata")
			end
		end




end
