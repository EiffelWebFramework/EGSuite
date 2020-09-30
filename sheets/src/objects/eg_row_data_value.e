note
	description: "Summary description for {EG_ROW_DATA_VALUE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ROW_DATA_VALUE


inherit
	ANY
		redefine
			out
		end

create
	make_from_effective_value,
	make_from_json


feature {NONE} -- Initialization

	make_from_effective_value (v: like effective_value)
		do
			effective_value := v
		ensure
			effective_value = v
		end

	make_from_json (a_json_o: JSON_OBJECT; an_index: like index)
		require
			valid_index (an_index)
		do
			index := an_index
			user_entered_value := string_value (a_json_o, Json_key_user_entered_value)
			effective_value := string_value (a_json_o, Json_key_effective_value)
			formatted_value := string_value (a_json_o, Json_key_user_formatted_value)
		ensure
			index = an_index
		end

feature -- Access

	Json_key_user_entered_value: STRING = "userEnteredValue"
	Json_key_effective_value: STRING = "effectiveValue"
	Json_key_user_formatted_value : STRING = "formattedValue"
	Json_key_user_effective_format: STRING = "effectiveFormat"
	Json_key_string_value: STRING = "stringValue"


	effective_value,
	user_entered_value,
	formatted_value: detachable STRING

	index: INTEGER

--	effective_format: -- implement me


feature -- Validation

	valid_index (an_index: like index): BOOLEAN
		do
			Result := an_index > 0
		end

feature -- Output

	out: STRING
		local
			l_sep: STRING
		do
			l_sep := "|"
			Result := ""
			if attached effective_value as l_v then
				Result.append ("effective_value:" + l_v + l_sep)
			end
			if attached user_entered_value as l_v then
				Result.append ("user_entered_value:" + l_v + l_sep)
			end
			if Result.ends_with (l_sep) then
				Result.remove_tail (l_sep.count)
			end
		end

feature {NONE} -- Implementation

	string_value (a_jso: JSON_OBJECT; a_key: STRING): like effective_value
		do
			if
				attached {JSON_OBJECT} a_jso.item (a_key) as l_jso and then
				attached {JSON_STRING} l_jso.item (Json_key_string_value) as l_res
			then
				Result := l_res.item
			end
		end

invariant
	valid_index (index)
end
