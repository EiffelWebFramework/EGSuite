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
			l_log_writter.enable_debug_log_level

			Result.enable_default_stderr_log
--			Result.default_log_writer_system.enable_debug_log_level
			Result.default_log_writer_stderr.enable_debug_log_level

			Result.register_log_writer (l_log_writter)
--			Result.enable_default_system_log

--			Result.write_debug ("***************** TEST DEBUG")
--			Result.write_information ("***************** TEST INFO")
--			Result.write_error ("***************** TEST ERROR")

		end

end
