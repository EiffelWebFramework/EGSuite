note
	description: "Query parameters that apply to all Google Sheets API operations are documented at System Parameters. "
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/query-parameters", "protocol=uri"
	EIS: "name=", "src=https://cloud.google.com/apis/docs/system-parameters", "protocl=uri"

class
	EG_STANDARD_PARAMETERS

inherit

	STRING_TABLE [STRING]

create
	make, make_equal, make_caseless, make_equal_caseless

feature -- Access

	fields: detachable STRING
			-- FieldMask(google.protobuf.FieldMask) used for response filtering. If empty, all fields will be returned.

	include_fields
		do
			if attached fields as l_fields then
				force (l_fields, "fields")
			else
				force ("", "fields")
			end
		end

	include_pretty_print (a_val: BOOLEAN)
			-- Pretty-print JSON response. Supported values are true (default), false.
		do
			force (a_val.out, "prettyPrint")
		end

feature -- Element Change

	add_fields (a_val: STRING)
			-- Add a value `a_val` to field mask to filter response.
		local
			l_fields: STRING
		do
			l_fields := fields
			if l_fields /= Void then
				l_fields.append_character (',')
				l_fields.append (a_val)
			else
				create l_fields.make_empty
				l_fields.append (a_val)
			end
			fields := l_fields
		end

end
