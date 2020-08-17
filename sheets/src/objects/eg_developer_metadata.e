note
	description: "[
		Developer metadata associated with a location or object in a spreadsheet. 
		Developer metadata may be used to associate arbitrary data with various parts of a spreadsheet and will remain associated at those locations as they move around and the spreadsheet is edited. 
		For example, if developer metadata is associated with row 5 and another row is then subsequently inserted above row 5, that original metadata will still be associated with the row 
		it was first associated with (what is now row 6). If the associated object is deleted its metadata is deleted too.


		{
		  "metadataId": integer,
		  "metadataKey": string,
		  "metadataValue": string,
		  "location": {
		    object (DeveloperMetadataLocation)
		  },
		  "visibility": enum (DeveloperMetadataVisibility)
		}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Developer Metadata", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.developerMetadata#resource:-developermetadata", "protocol=uri"

class
	EG_DEVELOPER_METADATA

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialize

	default_create
		do
			create metadata_key.make_empty
			create metadata_value.make_empty
			create location
			create visibility
		end

feature -- Access

	metadata_id: INTEGER
		-- The spreadsheet-scoped unique ID that identifies the metadata. IDs may be specified when metadata is created, otherwise one will be randomly generated and assigned. Must be positive.

	metadata_key: STRING
		-- The metadata key. There may be multiple metadata in a spreadsheet with the same key. Developer metadata must always have a key specified.

	metadata_value: STRING
		-- Data associated with the metadata's key.

	location: EG_DEVELOPER_METADATA_LOCATION
		-- The location where the metadata is associated.

	visibility: EG_DEVELOPER_METADATA_VISIBILITY
		-- The metadata visibility. Developer metadata must always have a visibility specified.


feature -- Element Change

	set_metadata_id (a_id: like metadata_id)
		do
			metadata_id := a_id
		ensure
			metadata_id_set: metadata_id = a_id
		end

	set_metadata_key (a_key: like metadata_key)
		do
			metadata_key := a_key
		ensure
			metadata_key_set: metadata_key = a_key
		end

	set_metadata_value (a_value: like metadata_value)
		do
			metadata_value := a_value
		ensure
			metadata_value_set: metadata_value = a_value
		end

	set_location (a_location: like location)
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_visibility (a_visibility: like visibility)
		do
			visibility := a_visibility
		ensure
			visibility_set: visibility = a_visibility
		end

end
