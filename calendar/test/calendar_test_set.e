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


			create calendar_event.make (start_date, end_date)
			create calendar_event_p.make (calendar_event)

			expected_json := "{%"start%":{%"date%":%"" + d.formatted_out ("YYYY-[0]MM-[0]DD") + "%",%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T"+ dt.formatted_out ("[0]hh:[0]mi") +
												"%",%"timeZone%":%"" + tz + "%"}" +  ",%"end%":" +
												"{%"date%":%"" + d.formatted_out ("YYYY-[0]MM-[0]DD") + "%",%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T"+ dt.formatted_out ("[0]hh:[0]mi") +
												"%",%"timeZone%":%"" + tz + "%"}" + "}"


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

			expected_json := "{%"date%":%"" + d.formatted_out ("YYYY-[0]MM-[0]DD") + "%",%"dateTime%":%"" + dt.formatted_out ("YYYY-[0]MM-[0]DD") + "T" + dt.formatted_out ("[0]hh:[0]mi") +
												"%",%"timeZone%":%"" + tz + "%"}"
			assert_strings_equal ("Simple test of calendar date", expected_json, calendar_date.json_out)

		end


feature {NONE}

simple_start_end_json : STRING = "[
{"start":"test","end":"test"}
]"

simple_start_json : STRING = "[
{"start":"test"}
]"

end


