note
	description: "Summary description for {CALENDAR_START_PAYLOAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR_DATE_PAYLOAD

	inherit
		JSON_SERIALIZABLE
			undefine
				default_create
				redefine
					json_out,
				eiffel_date_to_json_string,
				eiffel_date_time_to_json_string
			end

create
	make_with_date,
	default_create


feature

make_with_date(d: CALENDAR_DATE)
do
	date := d.a_date
	datetime := d.a_date_time
	timezone := d.a_time_zone
 end


default_create
do
	create date.make_now
	create datetime.make_now
	create timezone.make_empty
 end

	date: DATE
			-- What is the `date' of the Event?
		attribute
			create Result.make_now
		end

	datetime: DATE_TIME
			-- What is the `datetime' of the Event?
		attribute
			create Result.make_now
		end

	timeZone: STRING
			-- What `timezone' is the Event in?
		attribute
			create Result.make_empty
		end
feature  -- Implementation

	eiffel_date_to_json_string (a_key: STRING; a_date: DATE): JSON_STRING
			-- Convert `a_date' to JSON_STRING with `a_key'
		do
			create Result.make_from_string_32 (a_date.formatted_out ("YYYY-[0]MM-[0]DD"))
		end


		eiffel_date_time_to_json_string (a_key: STRING; a_date_time: DATE_TIME): JSON_STRING
				-- Convert `a_date_time' to JSON_STRING with `a_key'
			do
				create Result.make_from_string_32 (a_date_time.formatted_out ("YYYY-[0]MM-[0]DD:[0]hh:[0]mi"))
			end



	json_out: STRING
			--<Precursor>
			-- Convert `end_event' to "end", `datetime' to "dateTime", `timezone' to "timeZone" per Google.
		do
			Result := Precursor
			Result.replace_substring_all ("ending", "end")
			Result.replace_substring_all ("datetime", "dateTime")
			Result.replace_substring_all ("timezone", "timeZone")
		end

	metadata_refreshed (a_current: ANY): ARRAY [JSON_METADATA]
		do
			Result := <<
						create {JSON_METADATA}.make_text_default
						>>
		end

	convertible_features (a_object: ANY): ARRAY [STRING]
			-- <Precursor>
		once
			Result := <<"date","datetime","timezone">>
--			Result := <<"date","dateTime","timeZone">>
		end



end
