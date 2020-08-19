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

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature -- {NONE}

	default_create
		do
			create id.make_empty
			create url.make_empty
			create properties
			create {ARRAYED_LIST [EG_SHEET]} sheets.make (0)
			create {ARRAYED_LIST [EG_NAMED_RANGE]} named_ranges.make (0)
			create {ARRAYED_LIST [EG_DEVELOPER_METADATA]} developer_metadata.make (0)
		ensure then
			id_set: id.is_empty
			url_set: url.is_empty
		end

feature -- Access

	id: IMMUTABLE_STRING_8
			-- The ID of the spreadsheet. This field is read-only.

	properties: EG_SPREADSHEET_PROPERTIES
			-- Overall properties of a spreadsheet.

	sheets: LIST [EG_SHEET]
			-- The sheets that are part of a spreadsheet.

	named_ranges: LIST [EG_NAMED_RANGE]
			-- The named ranges defined in a spreadsheet.

	url: IMMUTABLE_STRING_8
			-- The url of the spreadsheet. This field is read-only.

	developer_metadata: LIST [EG_DEVELOPER_METADATA]
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
		do
			sheets.force (a_sheet)
		end

	set_sheets (a_sheets: like sheets)
		do
			sheets := a_sheets
		ensure
			sheets_set: sheets = a_sheets
		end

	force_name_range (a_range: EG_NAMED_RANGE)
			-- Add a range `a_range` to the list of ranges.
		do
			named_ranges.force (a_range)
		end

	set_named_ranges (a_named_ranges: like named_ranges)
		do
			named_ranges := a_named_ranges
		ensure
			named_ranges_set: named_ranges = a_named_ranges
		end

	force_developer_metadata (a_metadata: EG_DEVELOPER_METADATA)
			-- Set developer metadata `a_metadata` to metadata.
		do
			developer_metadata.force (a_metadata)
		end

	set_developer_metadata (a_metadata: like developer_metadata)
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
			id_set: id.is_case_insensitive_equal (a_id)
		end

	set_url (a_url: STRING)
			-- Set url with `a_url`
		require
			not_url_set: not is_url_set
		do
			is_url_set := True
			create url.make_from_string (a_url)
		ensure
			url_set: url.is_case_insensitive_equal (a_url)
			is_url_set: is_url_set
		end
end
