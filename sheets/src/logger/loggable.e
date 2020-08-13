note
	description: "Summary description for {LOGGABLE}."
	author: "Philippe Gachoud"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGABLE

feature -- Access

	logger: LOG_LOGGING_FACILITY
		once
			create Result.make
--				Result.set_file_path_sep (l_app_instance_sep.log_file_path_s)
--			Result.register
		end

end
