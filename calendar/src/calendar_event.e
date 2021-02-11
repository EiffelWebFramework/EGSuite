note
	description: "Summary description for {CALENDAR_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR_EVENT

	create
		make_generate_id,
		make

	feature


		make(start_date, end_date : CALENDAR_DATE; event_id : STRING)
		do
			sd := start_date
			ed := end_date
			id := event_id
		end


		make_generate_id(start_date, end_date : CALENDAR_DATE)
		do
			sd := start_date
			ed := end_date
			id := "create unique id"
		end

		sd:CALENDAR_DATE
		ed:CALENDAR_DATE
		id : STRING




end
