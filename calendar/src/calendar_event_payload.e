note
	description: "Summary description for {CALENDAR_EVENT_PAYLOD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR_EVENT_PAYLOAD

	inherit
		JSON_SERIALIZABLE
			undefine
				default_create
			redefine
				json_out
			end

create
	make,
	default_create


feature

make (ce: CALENDAR_EVENT )
do
	kind:= "calendar#event"
	summary := ce.summary
	create start.make_with_date (ce.sd)
 	create ending.make_with_date (ce.ed)
 	id := ce.id
end

default_create
do
	id := ""
 	kind:= ""
 	summary:=""
 	create start
 	create ending
end

 	id : STRING
 	kind: STRING
 	summary: STRING
 	start:  CALENDAR_DATE_PAYLOAD
 	ending:  CALENDAR_DATE_PAYLOAD



feature {NONE} -- Implementation: Representation Constants

--	current_representation: STRING
--	do
--		Result := "{" +
--		"%"start%":%"" + start + "%"," +
--		"%"end%":%"" + ending + "%"" +
--		"}"

--	end

feature -- Implementation: Mock Features




feature -- Implementation
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
			Result := <<"summary","kind","start", "ending","id">>
		end

end
