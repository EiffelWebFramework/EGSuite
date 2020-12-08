note
	description: "Summary description for {EG_CALENDAR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_CALENDAR_API

inherit
	EG_COMMON_API

create
	make

feature {NONE} -- Initialization

	make (a_access_token: READABLE_STRING_32)
		do
				-- Using a code verifier
			access_token := a_access_token
			enable_version_3
			default_scope
		end

	default_scope
		do
			create {ARRAYED_LIST [STRING_8]} scopes.make (5)
			add_scope ("https://www.googleapis.com/auth/calendar")
		end

	enable_version_3
			-- Enable Google Calendar version v3.
		do
			version := "v3"
		ensure
			version_set: version.same_string ("v3")
		end

feature -- Access

	list_calendars: detachable STRING
		do
			api_get_call (calendar_url("users/me/calendarList", Void), Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	list_primary_calendar: detachable STRING
		do
			api_get_call (calendar_url("calendars/primary", Void), Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	list_primary_calendar_events: detachable STRING
		do
			api_get_call (calendar_url ("calendars/primary/events", Void), Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	create_calendar (name_of_calendar: STRING): detachable STRING
		do
			api_post_call (calendar_url ("calendars", Void), Void, payload_create_calendar(name_of_calendar), Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

	create_calendar_event (name_of_calendar: STRING; payload: CALENDAR_EVENT_PAYLOAD): detachable STRING
		require
			start_date_exists: attached payload.start
			ending_date_exists: attached payload.ending

		do
			api_post_call (calendar_url("calendars/" + name_of_calendar + "/events", Void), Void, payload_create_calendar_event, Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end


feature -- Calenader URL

	calendar_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Calenader url endpoint
			--| TODO, check if a_params is really neeed.
		note
			eis: "name=Calendaer service endpoint", "src=https://developers.google.com/calendar/v3/reference", "protocol=uri"
		require
			a_query_attached: a_query /= Void
		do
			create 	Result.make_from_string (endpoint_url)
			Result.append ("/")
			Result.append (version)
			Result.append ("/")
			Result.append (a_query)
			if attached a_params then
				Result.append_character ('?')
				Result.append (a_params)
			end
		ensure
			Result_attached: Result /= Void
		end


feature -- Access		

	endpoint_url: STRING
			-- <Precursor>
		do
			Result := "https://www.googleapis.com/calendar"
		end

	payload_create_calendar(name:STRING): STRING
		local
			l_res: JSON_OBJECT
		do
			create l_res.make_with_capacity (5)
			l_res.put_string (name, "summary")
			Result := l_res.representation
		end

	payload_create_calendar_event: STRING
		note
			EIS: "name=calendar event", "src=https://developers.google.com/calendar/v3/reference/events#resource"
		local
			l_res: JSON_OBJECT
			l_jsa_start: JSON_STRING
			l_jsa_end: JSON_ARRAY
		do

			create l_res.make_with_capacity (5)
				-- Add the required parameters in the paylod: "start" and "end"
				--https://developers.google.com/calendar/v3/reference/events/insert

				--  "start": {
				--    "date": date,
				--    "dateTime": datetime,
				--    "timeZone": string
				--  },
				--  "end": {
				--    "date": date,
				--    "dateTime": datetime,
				--    "timeZone": string
				--  }

				--?????????????

			Result := l_res.representation
		end

end
