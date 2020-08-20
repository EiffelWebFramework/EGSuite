note
	description: "[
	The number format of a cell.
	
	JSON representation

		{
		  "type": enum (NumberFormatType),
		  "pattern": string
		}
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_NUMBER_FORMAT

feature

	type: detachable EG_NUMBER_FORMAT_TYPE
		-- The type of the number format. When writing, this field must be set.

	pattern: detachable STRING
		-- Pattern string used for formatting. If not set, a default pattern based on the user's locale will be used if necessary for the given type.
		-- See the Date and Number Formats guide (https://developers.google.com/sheets/api/guides/formats) for more information about the supported patterns.

feature -- Element Change

	set_type (a_type: like type)
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

	set_pattern (a_pattern: like pattern)
		do
			pattern := a_pattern
		ensure
			pattern_set: pattern = a_pattern
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			if attached type as l_type then
				Result.put (l_type.to_json, "type")
			end
			if attached pattern as l_pattern then
				Result.put (create {JSON_STRING}.make_from_string (l_pattern), "pattern")
			end
		end

end
