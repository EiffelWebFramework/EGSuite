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

inherit

	ANY
		redefine
			default_create
		end

create
	default_create


feature	{NONE} -- Initialization

	default_create
		do
			create location_type
		end

feature -- Access

	location_type: EG_DEVELOPER_METADATA_LOCATION_TYPE


end
