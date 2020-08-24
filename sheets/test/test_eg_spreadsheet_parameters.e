note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EG_SPREADSHEET_PARAMETERS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_get_spreadsheets_parameters_empty
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
		do
			create l_qry.make (1)
			assert ("Empty", to_query (l_qry).is_empty)
		end

	test_get_spreadsheets_parameters_one_fields
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
		do
			create l_qry.make (1)
			l_qry.add_fields ("sheets.data")
			l_qry.include_fields
			assert ("fields", to_query (l_qry).is_case_insensitive_equal ("fields=sheets.data"))
		end

	test_get_spreadsheets_parameters_multiple_fields
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
		do
			create l_qry.make (1)
			l_qry.add_fields ("sheets.data")
			l_qry.add_fields ("properties.title")
			l_qry.add_fields ("sheets.properties")
			l_qry.include_fields
			assert ("fields", to_query (l_qry).is_case_insensitive_equal ("fields=sheets.data,properties.title,sheets.properties"))
		end

	test_get_spreadsheets_parameters_includegriddata_false
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
		do
			create l_qry.make (1)
			l_qry.include_grid_data (False)
			assert ("includeGridData", to_query (l_qry).is_case_insensitive_equal ("includeGridData=False"))
		end

	test_get_spreadsheets_parameters_includegriddata_true
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
		do
			create l_qry.make (1)
			l_qry.include_grid_data (True)
			assert ("includeGridData", to_query (l_qry).is_case_insensitive_equal ("includeGridData=True"))
		end


	test_get_spreadsheets_parameters_range
			-- New test routine
		local
			l_qry: EG_SPREADSHEET_PARAMETERS
			s: STRING
		do
			create l_qry.make (1)
			l_qry.include_ranges (create {ARRAYED_LIST[STRING]}.make_from_array ({ARRAY[STRING]}<<"Sheet1!A1:B2">>))
			assert ("includeGridData", to_query (l_qry).is_case_insensitive_equal ("ranges=Sheet1!A1:B2"))
		end



feature -- To Query

	to_query (a_qry: EG_SPREADSHEET_PARAMETERS): STRING
		do
			create Result.make_empty
			from
				a_qry.start
			until
				a_qry.after
			loop
				Result.append_string_general (a_qry.key_for_iteration)
				Result.append_character ('=')
				Result.append_string_general (a_qry.item_for_iteration)
				Result.append_character ('&')
				a_qry.forth
			end
			Result.remove_tail (1)
		end

end


