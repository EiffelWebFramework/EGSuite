note
	description: "[
		A location where metadata may be associated in a spreadsheet.
	
	{
	  "locationType": enum (DeveloperMetadataLocationType),

	  // Union field location can be only one of the following:
	  "spreadsheet": boolean,
	  "sheetId": integer,
	  "dimensionRange": {
	    object (DimensionRange)
	  }
	  // End of list of possible types for union field location.
	}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Developer Metadata Location", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.developerMetadata#developermetadatalocation", "protocol=uri"

class
	EG_DEVELOPER_METADATA_LOCATION

feature -- Access

	location_type: detachable EG_DEVELOPER_METADATA_LOCATION_TYPE


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			-- TOSO
		end

end
