note
	description: "Summary description for {EG_ROW_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_ROW_DATA

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
		do
			check attached {JSON_ARRAY} a_json_o.item (Json_key_row_data_values) as l_jsa then
				create values.make (l_jsa.count)
				across
					l_jsa is l_json_row_data
				loop
					check
						is_json_object: attached {JSON_OBJECT} l_json_row_data as l_jso
					then
						create l_rd.make_from_json (l_jso)
						values.extend (l_rd)
					end
				end
			end
		end

feature -- Access

	Json_key_row_data_values: STRING = "values"

	values: ARRAYED_LIST[EG_ROW_DATA_VALUE]

end
