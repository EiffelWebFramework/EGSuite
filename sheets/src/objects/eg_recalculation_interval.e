note
	description: "[
		An enumeration of the possible recalculation interval options.
	
		Enums
	RECALCULATION_INTERVAL_UNSPECIFIED 	Default value. This value must not be used.
	ON_CHANGE 							Volatile functions are updated on every change.
	MINUTE 								Volatile functions are updated on every change and every minute.
	HOUR 								Volatile functions are updated on every change and hourly.	
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets#recalculationinterval", "protocol=uri"

class
	EG_RECALCULATION_INTERVAL

inherit

	EG_ENUM
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			set_value (recalculation_interval_unspecified)
		end

	recalculation_interval_unspecified: INTEGER = 1
			--Default value. This value must not be used.

	on_change: INTEGER = 2
			-- Volatile functions are updated on every change.

	minute: INTEGER = 3
			-- Volatile functions are updated on every change and every minute.

	hour: INTEGER = 4
			--Volatile functions are updated on every change and hourly.

feature -- Change Elements

	set_on_change
		do
			set_value (on_change)
		ensure
			value_set_with_on_change: value = on_change
		end

	set_minute
		do
			set_value (minute)
		ensure
			value_set_with_minute: value = minute
		end

	set_hour
		do
			set_value (hour)
		ensure
			value_set_with_hour: value = hour
		end

feature -- Status Report

	is_on_change: BOOLEAN
		do
			Result := value = on_change
		end

	is_minute: BOOLEAN
		do
			Result := value = minute
		end

	is_hour: BOOLEAN
		do
			Result := value = hour
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = recalculation_interval_unspecified or else
			          a_value = on_change or else
			          a_value = minute or else
			          a_value = hour
		end

feature -- Eiffel to JSON

	to_json: JSON_STRING
			-- JSON representation of the current object
		do
			create Result.make_from_string ("RECALCULATION_INTERVAL_UNSPECIFIED")
			if is_hour then
				create Result.make_from_string ("HOUR")
			elseif is_minute  then
				create Result.make_from_string ("MINUTE")
			elseif is_on_change then
				create Result.make_from_string ("ON_CHANGE")
			else
				create Result.make_from_string ("RECALCULATION_INTERVAL_UNSPECIFIED")
			end
		end

end
