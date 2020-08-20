note
	description: "[
	Settings to control how circular dependencies are resolved with iterative calculation.
	
	JSON Representation
	{
	  "maxIterations": integer,
	  "convergenceThreshold": number
	}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Iteratice calculation settings", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#iterativecalculationsettings", "protocol=uri"

class
	EG_ITERATIVE_CALCULATION_SETTINGS

feature -- Access

	max_iterations: INTEGER
			-- When iterative calculation is enabled, the maximum number of calculation rounds to perform.

	convergence_threshold: INTEGER
			-- When iterative calculation is enabled and successive results differ by less than this threshold value, the calculation rounds stop.


feature -- Change Element

	set_max_iterations (a_val: INTEGER)
			-- Set `max_iterations` with `a_val`.
		do
			max_iterations := a_val
		ensure
			max_iterations_set: max_iterations = a_val
		end

	set_convergence_threshold (a_val: INTEGER)
			-- 	Set `convergence_threshold` with `a_val`.
		do
			convergence_threshold := a_val
		ensure
			convergence_threshold_set: convergence_threshold = a_val
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_with_capacity (2)
			Result.put (create {JSON_NUMBER}.make_integer (max_iterations), "maxIterations")
			Result.put (create {JSON_NUMBER}.make_integer (convergence_threshold), "convergenceThreshold")
		end

end

