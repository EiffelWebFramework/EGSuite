note
	description: "Abstract Enumeration for EG"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_ENUM


feature -- Status Report

	is_valid_state: BOOLEAN
			-- Is the value of the enumeration valid?
		do
			Result := is_valid_value (value)
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		deferred
		end
feature -- Access

	value: INTEGER
			-- The current value of the enumeration.

feature -- Change Element

	set_value (a_value: INTEGER)
			-- Change value with `a_value`.
		require
			is_valid_value (a_value)
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

invariant
	enum_valid: is_valid_state

end
