note
	description: "Summary description for {EG_SPREADSHEET_PARAM}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/get#query-parameters", "protocol=uri"
class
	EG_SPREADSHEET_PARAMETERS

inherit

	EG_STANDARD_PARAMETERS


create
	make, make_equal, make_caseless, make_equal_caseless

feature -- Access

	include_grid_data (a_val: BOOLEAN)
		do
			force (a_val.out, "includeGridData")
		end

	include_ranges (a_ranges: detachable LIST [STRING])
			-- Each range in the list should look like
			-- Sheet1!A:B check range definition.
		local
			ranges: STRING
			s: STRING
		do
			s := (create{URL_ENCODER}).encoded_string ("Sheet1!A1:B5")
			if attached a_ranges then
				create ranges.make_empty
				across a_ranges as ic loop
					ranges.append (ic.item)
					ranges.append_character (',')
				end
				ranges.remove_tail (1)
				force (ranges, "ranges")
			end
		end

end
