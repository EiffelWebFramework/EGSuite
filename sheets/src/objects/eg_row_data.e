note
	description: "Summary description for {EG_ROW_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ROW_DATA

inherit
	ANY
		redefine
			out
		end

create
	make,
	make_from_json

feature {NONE} -- Initialization

	make (n: like values.count)
		do
			create values.make (n)
		end

	make_from_json (a_json_o: JSON_OBJECT)
		local
			l_rd: like values.item
			l_index: INTEGER
		do
			check attached {JSON_ARRAY} a_json_o.item (Json_key_row_data_values) as l_jsa then
				create values.make (l_jsa.count)
				l_index := 1
				across
					l_jsa as l_json_row_data
				loop
					check
						is_json_object: attached {JSON_OBJECT} l_json_row_data.item as l_jso
					then
						create l_rd.make_from_json (l_jso, l_index)
						values.extend (l_rd)
					end
					l_index := l_index + 1
				end
			end
		end

feature -- Access

	Json_key_row_data_values: STRING = "values"

	values: ARRAYED_LIST[EG_ROW_DATA_VALUE]

feature -- Output

	out: STRING
		local
			l_sep: STRING
		do
			l_sep := "%N"
			Result := ""
			across
				values is l_val
			loop
				Result.append (l_val.out + l_sep)
			end
			if Result.ends_with (l_sep) then
				Result.remove_tail (l_sep.count)
			end
		end

end
