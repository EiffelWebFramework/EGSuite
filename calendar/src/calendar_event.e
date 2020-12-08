note
	description: "Summary description for {CALENDAR_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR_EVENT

	create
		make

	feature

		make(start_date, end_date : CALENDAR_DATE)
local
		tools :DATE_TIME_TOOLS
		do
			sd := start_date
			ed := end_date

		end

		sd:CALENDAR_DATE
		ed:CALENDAR_DATE


end
