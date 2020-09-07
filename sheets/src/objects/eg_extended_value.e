note
	description: "[
	
	The kinds of value that a cell in a spreadsheet can have. 	
	{

	  // Union field value can be only one of the following:
	  "numberValue": number,
	  "stringValue": string,
	  "boolValue": boolean,
	  "formulaValue": string,
	  "errorValue": {
	    object (ErrorValue)
	  }
	  // End of list of possible types for union field value.
	}

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_EXTENDED_VALUE


feature -- Access

	number_value: REAL
			-- Represents a double value.
			-- Note: Dates, Times and DateTimes are represented as doubles in "serial number" format.

	string_value: detachable STRING
			-- Represents a string value. Leading single quotes are not included.
			-- For example, if the user typed '123 into the UI, this would be represented as a stringValue of "123".

	bool_value: BOOLEAN
			-- Represents a boolean value.

	formula_value: detachable STRING
			-- Represents a formula.

	error_value: detachable EG_ERROR_VALUE
			-- Represents an error. This field is read-only. 						

feature -- Status Report

	is_number_value: BOOLEAN
			-- Is the current value a number?

	is_string_value: BOOLEAN
			-- Is the current value an string?

	is_bool_value: BOOLEAN
			-- Is the current value a boolean?

	is_formula_value: BOOLEAN
			-- Is the current value a formula?

	is_error_value: BOOLEAN
			-- Is the current value an error value?

feature -- Element Change

	set_number_value (a_value: like number_value)
			-- Set `number_value` with `a_vaue`?
		do
			is_number_value := True
			is_string_value := False
			is_bool_value   := False
			is_formula_value:= False
			is_error_value  := False

			number_value := a_value
		ensure
			number_value_set: number_value = a_value
			union_field_number: is_number_value implies
							( is_string_value = False and then is_bool_value = False and then is_formula_value = False and then is_error_value = False)
		end

	set_string_value (a_value: like string_value)
			-- Set `string_value` with `a_vaue`?
		do
			is_number_value := False
			is_string_value := True
			is_bool_value   := False
			is_formula_value:= False
			is_error_value  := False

			string_value := a_value
		ensure
			string_value_set: string_value = a_value
			union_field_string: is_string_value implies
							( is_number_value = False and then is_bool_value = False and then is_formula_value = False and then is_error_value = False)
		end

end
