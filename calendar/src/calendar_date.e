note
	description: "Summary description for {CALENDAR_DATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR_DATE

	create
		make

	feature

		make(d:DATE; dt: DATE_TIME; tz: STRING)
local
		tools :DATE_TIME_TOOLS
		do
			a_date := d





			a_date_time := dt
			a_time_zone := tz

		end

		a_date:DATE
		a_date_time : DATE_TIME
		a_time_zone : STRING


end
