note
	description: "[
		An enumeration of possible metadata visibilities.
		
		Enums
		DEVELOPER_METADATA_VISIBILITY_UNSPECIFIED 	Default value.
		DOCUMENT 									Document-visible metadata is accessible from any developer project with access to the document.
		PROJECT 									Project-visible metadata is only visible to and accessible by the developer project that created the metadata.
		
	]"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=DeveloperMetadataVisibility", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets.developerMetadata#developermetadatavisibility", "protocol=uri"
class
	EG_DEVELOPER_METADATA_VISIBILITY

inherit

	EG_ENUM
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			set_value (developer_metadata_visibility_unspecified)
		end

	developer_metadata_visibility_unspecified: INTEGER = 1
			-- Default value.

	document: INTEGER = 2
			-- Document-visible metadata is accessible from any developer project with access to the document.

	project: INTEGER = 3
			-- Project-visible metadata is only visible to and accessible by the developer project that created the metadata.

feature -- Change Elements

	set_document
		do
			set_value (document)
		ensure
			value_set_with_document: value = document
		end

	set_project
		do
			set_value (project)
		ensure
			value_set_with_project: value = project
		end

feature -- Status Report

	is_document: BOOLEAN
		do
			Result := value = document
		end

	is_project: BOOLEAN
		do
			Result := value = project
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = developer_metadata_visibility_unspecified or else
			          a_value = document or else
			          a_value = project
		end
end
