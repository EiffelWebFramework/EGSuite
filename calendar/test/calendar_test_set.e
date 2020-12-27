note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	CALENDAR_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		redefine
			on_prepare,
			on_clean
		end

	EQA_COMMONLY_USED_ASSERTIONS
			undefine
				default_create
			end


feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
--			assert ("not_implemented", False)
		end

	on_clean
			-- <Precursor>
		do
--			assert ("not_implemented", False)
		end

feature -- Test routines

	test_calendar_event_payload
			-- New test routine
		local

			calendar_event_p : CALENDAR_EVENT_PAYLOAD
			calendar_event : CALENDAR_EVENT
			start_date : CALENDAR_DATE
			end_date : CALENDAR_DATE

			d: DATE
			dt: DATE_TIME
			tz : STRING
			cd : CALENDAR_DATE
			expected_json : STRING

		do
			create d.make_now
			create dt.make_now
			tz := "CET"
			create start_date.make (d, dt, tz)
			create end_date.make (d, dt, tz)


			create calendar_event.make (start_date, end_date, "testcalendareventpaload123")
			create calendar_event_p.make (calendar_event)

-- Removed date might be temporary			expected_json := "{%"start%":{%"date%":%"" + d.formatted_out ("YYYY-[0]MM-[0]DD") + "%",%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T"+ dt.formatted_out ("[0]hh:[0]mi") +
			expected_json := "{%"start%":{%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T"+ dt.formatted_out ("[0]hh:[0]mi") + ":00" +
												"%",%"timeZone%":%"" + tz + "%"}" +  ",%"end%":" +
												"{%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T"+ dt.formatted_out ("[0]hh:[0]mi") + ":00" +
												"%",%"timeZone%":%"" + tz + "%"}" + ",%"kind%":%"calendar#event%",%"summary%":%"test from Wunderlist replacer%",%"id%":%"testcalendareventpaload123%"}"


			assert_strings_equal ("Simple test of attributes", expected_json, calendar_event_p.json_out)

		end


	test_calendar_date_payload
			-- New test routine
		local

			calendar_date : CALENDAR_DATE_PAYLOAD
			d: DATE
			dt: DATE_TIME
			tz : STRING
			cd : CALENDAR_DATE
			expected_json : STRING
		do
			create d.make_now
			create dt.make_now
			tz := "CET"
			create cd.make (d, dt, tz)


			create calendar_date.make_with_date (cd)
-- I removed DATE as part of the json. I am not sure that it is necessary but since it is working I will stick to the new implementation
--			expected_json := "{%"date%":%"" + d.formatted_out ("YYYY-[0]MM-[0]DD") + "%",%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T" + dt.formatted_out ("[0]hh:[0]mi") +
--												"%",%"timeZone%":%"" + tz + "%"}"


			expected_json := "{%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T" + dt.formatted_out ("[0]hh:[0]mi") + ":00" +
												"%",%"timeZone%":%"" + tz + "%"}"


			assert_strings_equal ("Simple test of calendar date", expected_json, calendar_date.json_out)

		end

		test_calendar_event_id
			local
				calednar_api : EG_CALENDAR_API
			do
				create calednar_api.make ("DUMMAYSTRING")

				assert_booleans_equal ("Should be a correct id", true, calednar_api.check_event_id ("aaaaaaaaaa"))
				assert_booleans_equal ("Too few characters", false, calednar_api.check_event_id ("aaaa5"))
				assert_booleans_equal ("Minimum nmber of characters", true, calednar_api.check_event_id ("aaaaa6"))
				assert_booleans_equal ("Too many characters", false, calednar_api.check_event_id ( create {STRING}.make_filled ('a', 1024)))
				assert_booleans_equal ("Maximum number if characters", true, calednar_api.check_event_id ( create {STRING}.make_filled ('a', 1023)))

				assert_booleans_equal ("Uppercase not allowed", false, calednar_api.check_event_id ("aaaaAaaaaa"))

			end


feature {NONE}

simple_start_end_json : STRING = "[
{"start":"test","end":"test"}
]"

simple_start_json : STRING = "[
{"start":"test"}
]"

end


