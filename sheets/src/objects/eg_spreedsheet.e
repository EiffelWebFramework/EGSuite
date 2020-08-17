note
	description: "[
		Object representing an SpreedSheet Resource
		
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
	EG_SPREEDSHEET

create
	make

feature -- {NONE}

	make (a_id: STRING_8; a_url: STRING_8)
		do
			create id.make_from_string (a_id)
			create url.make_from_string (a_url)
			create properties.make
			create {ARRAYED_LIST [EG_SHEETS]} sheets.make (0)
			create {ARRAYED_LIST [EG_NAMED_RANGE]} named_ranges.make (0)
			create {ARRAYED_LIST [EG_DEVELOPER_METADATA]} developer_metadata.make (0)
		ensure
			id_set: id.is_case_insensitive_equal (a_id)
			url_set: url.is_case_insensitive_equal (a_url)
		end

feature -- Access

	id: IMMUTABLE_STRING_8
			-- The ID of the spreadsheet. This field is read-only.

	properties: EG_SPREADSHEET_PROPERTIES
			-- Overall properties of a spreadsheet.

	sheets: LIST [EG_SHEETS]
			-- The sheets that are part of a spreadsheet.

	named_ranges: LIST [EG_NAMED_RANGE]
			-- The named ranges defined in a spreadsheet.

	url: IMMUTABLE_STRING_8
			-- The url of the spreadsheet. This field is read-only.

	developer_metadata: LIST [EG_DEVELOPER_METADATA]
			-- The developer metadata associated with a spreadsheet.

feature -- Change Element

	set_protperty (a_properties: like properties)
			-- Set properties with `a_properties`.
		do
			properties := a_properties
		ensure
			properties_set: properties = a_properties
		end

	force_sheet (a_sheet: EG_SHEETS)
			-- Add a sheet `a_sheet` to the list of sheets.
		do
			sheets.force (a_sheet)
		end

	force_name_range (a_range: EG_NAMED_RANGE)
			-- Add a range `a_range` to the list of ranges.
		do
			named_ranges.force (a_range)
		end

	force_developer_metadata (a_metadata: EG_DEVELOPER_METADATA)
		do
			developer_metadata.force (a_metadata)
		end

end
