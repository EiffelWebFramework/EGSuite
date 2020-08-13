note
	description: "Summary description for {LOGGABLE}."
	author: "Philippe Gachoud"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGABLE

feature -- Access

	logger: LOG_LOGGING_FACILITY
		local
			l_log_writter: LOG_WRITER_FILE
		once
			create Result.make
--				Result.set_file_path_sep (l_app_instance_sep.log_file_path_s)
			create l_log_writter
			Result.register_log_writer (l_log_writter)
		end

end
