note
	description: "[
			The number format of the cell. In this documentation the locale is assumed to be en_US, but the actual format depends on the locale of the spreadsheet.
		
			Enums
			NUMBER_FORMAT_TYPE_UNSPECIFIED 	The number format is not specified and is based on the contents of the cell. Do not explicitly use this.
			TEXT 							Text formatting, e.g 1000.12
			NUMBER 							Number formatting, e.g, 1,000.12
			PERCENT 						Percent formatting, e.g 10.12%
			CURRENCY 						Currency formatting, e.g $1,000.12
			DATE 							Date formatting, e.g 9/26/2008
			TIME 							Time formatting, e.g 3:59:00 PM
			DATE_TIME 						Date+Time formatting, e.g 9/26/08 15:59:00
			SCIENTIFIC 						Scientific number formatting, e.g 1.01E+03
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_NUMBER_FORMAT_TYPE

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
			set_value (number_format_type_unspecified)
		end

	number_format_type_unspecified: INTEGER = 1
			-- The number format is not specified and is based on the contents of the cell. Do not explicitly use this.

	text: INTEGER = 2
			-- Text formatting, e.g 1000.12.

	number: INTEGER = 3
			-- Number formatting, e.g, 1,000.12

	percent: INTEGER = 3
			-- Percent formatting, e.g 10.12%

	currency: INTEGER = 4
			-- Currency formatting, e.g $1,000.12

	date: INTEGER = 5
			-- Date formatting, e.g 9/26/2008

	time: INTEGER = 6
			-- Time formatting, e.g 3:59:00 PM.

	date_time: INTEGER = 7
			-- Date+Time formatting, e.g 9/26/08 15:59:00

	scientific: INTEGER = 8
			-- Scientific number formatting, e.g 1.01E+03


feature -- Change Elements

	set_text
		do
			set_value (text)
		ensure
			value_set_with_text: value = text
		end

	set_number
		do
			set_value (number)
		ensure
			value_set_with_number: value = number
		end

	set_percent
		do
			set_value (percent)
		ensure
			value_set_with_percent: value = percent
		end

	set_currency
		do
			set_value (currency)
		ensure
			value_set_with_currency: value = currency
		end

	set_date
		do
			set_value (date)
		ensure
			value_set_with_date: value = date
		end

	set_time
		do
			set_value (time)
		ensure
			value_set_with_time: value = time
		end

	set_date_time
		do
			set_value (date_time)
		ensure
			value_set_with_time: value = date_time
		end

	set_scientific
		do
			set_value (scientific)
		ensure
			value_set_with_time: value = scientific
		end


feature -- Status Report

	is_text: BOOLEAN
		do
			Result := value = text
		end

	is_number: BOOLEAN
		do
			Result := value = number
		end

	is_percent: BOOLEAN
		do
			Result := value = percent
		end

	is_currency: BOOLEAN
		do
			Result := value = currency
		end

	is_date: BOOLEAN
		do
			Result := value = date
		end


	is_time: BOOLEAN
		do
			Result := value = time
		end

	is_date_time: BOOLEAN
		do
			Result := value = date_time
		end

	is_scientific: BOOLEAN
		do
			Result := value = scientific
		end

	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = number_format_type_unspecified or else
			          a_value = text or else
			          a_value = number or else
			          a_value = percent or else
			          a_value = currency or else
			          a_value = date or else
			          a_value = time or else
			          a_value = date_time or else
			          a_value = scientific
		end


feature -- Eiffel to JSON

	to_json: JSON_STRING
			-- Json representation of current object.
		do
			if is_text then
				Result := "TEXT"
			elseif is_number  then
				Result := "NUMBER"
			elseif is_percent then
				Result := "PERCENT"
			elseif is_currency then
				Result := "CURRENCY"
			elseif is_date then
				Result := "DATE"
			elseif is_time then
				Result := "TIME"
			elseif is_date_time then
				Result := "DATE_TIME"
			else
				Result := "NUMBER_FORMAT_TYPE_UNSPECIFIED"
			end
		end

end
