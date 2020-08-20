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

end
