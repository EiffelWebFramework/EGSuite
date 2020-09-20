note
	description: "Summary description for {EG_CALENDAR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EG_CALENDAR_API

inherit
	EG_SHEETS_API
	rename
		endpoint_sheets_url as endpoint_calendar_url
	redefine
		 endpoint_calendar_url
	end

create
	make

	feature list_calendars : detachable STRING
	do
			api_get_call ("https://www.googleapis.com/calendar/v3/users/me/calendarList" , Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
	end

	feature list_primary_calendar : detachable STRING
	do
			api_get_call ("https://www.googleapis.com/calendar/v3/calendars/primary" , Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
	end

	feature list_primary_calendar_events : detachable STRING
	do
			api_get_call ("https://www.googleapis.com/calendar/v3/calendars/primary/events" , Void)
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
	end

	feature create_calendar( name_of_calendar : STRING) : detachable STRING
	do
		api_post_call ("https://www.googleapis.com/calendar/v3/calendars" , Void , payload_create_calendar, Void)
		if
			attached last_response as l_response and then
			attached l_response.body as l_body
		then
			Result := l_body
		end
	end


	feature create_calendar_event( name_of_calendar : STRING; payload : CALENDAR_EVENT_PAYLOAD) : detachable STRING
	require
		start_date_exists: attached payload.start
		ending_date_exists: attached payload.ending

	do
		api_post_call ("https://www.googleapis.com/calendar/v3/calendars/" + name_of_calendar  + "/events", Void , payload_create_calendar_event, Void)
		if
			attached last_response as l_response and then
			attached l_response.body as l_body
		then
			Result := l_body
		end
	end



	endpoint_calendar_url: STRING
	do
		Result :=  "https://www.googleapis.com"
	end


	payload_create_calendar: STRING
		local
			l_res: JSON_OBJECT
		do
			create l_res.make_with_capacity (5)
			l_res.put_string ("BSharpABTODO", "summary")
			Result := l_res.representation
		end


	payload_create_calendar_event: STRING
		note
			EIS:"name=calendar event", "src=https://developers.google.com/calendar/v3/reference/events#resource"
		local
			l_res: JSON_OBJECT
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
