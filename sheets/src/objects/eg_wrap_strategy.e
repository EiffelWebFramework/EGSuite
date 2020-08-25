note
	description: "[
			Object rerpesenting How to wrap text in a cell. 
			
			
		WRAP_STRATEGY_UNSPECIFIED 	The default value, do not use.
		OVERFLOW_CELL 	            Lines that are longer than the cell width will be written in the next cell over, so long as that cell is empty. If the next cell over is non-empty, this behaves the same as CLIP . The text will never wrap to the next line unless the user manually inserts a new line. Example:

									| First sentence. |
									| Manual newline that is very long. <- Text continues into next cell
									| Next newline.   |

		LEGACY_WRAP

									This wrap strategy represents the old Google Sheets wrap strategy where words that are longer than a line are clipped rather than broken. This strategy is not supported on all platforms and is being phased out. Example:

									| Cell has a |
									| loooooooooo| <- Word is clipped.
									| word.      |

		CLIP 						Lines that are longer than the cell width will be clipped. The text will never wrap to the next line unless the user manually inserts a new line. Example:

									| First sentence. |
									| Manual newline t| <- Text is clipped
									| Next newline.   |

		WRAP 						Words that are longer than a line are wrapped at the character level rather than clipped. Example:

									| Cell has a |
									| loooooooooo| <- Word is broken.
									| ong word.  |
	]"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#wrapstrategy", "protocol=uri"
class
	EG_WRAP_STRATEGY


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
			set_value (wrap_strategy_unspecified)
		end

	wrap_strategy_unspecified: INTEGER = 1
			-- The default value, do not use.

	overflow_cell: INTEGER = 2
			-- Lines that are longer than the cell width will be written in the next cell over, so long as that cell is empty.
			-- If the next cell over is non-empty, this behaves the same as CLIP .
			-- The text will never wrap to the next line unless the user manually inserts a new line.

	legacy_wrap: INTEGER = 3
			-- This wrap strategy represents the old Google Sheets wrap strategy where words that are longer than a line are clipped rather than broken.
			-- This strategy is not supported on all platforms and is being phased out

	clip: INTEGER = 4
			-- Lines that are longer than the cell width will be clipped. The text will never wrap to the next line unless the user manually inserts a new line.

	wrap: INTEGER = 5
			-- Words that are longer than a line are wrapped at the character level rather than clipped.		

feature -- Change Elements

	set_overflow_cell
		do
			set_value (overflow_cell)
		ensure
			value_set_with_overflow_cell: value = overflow_cell
		end

	set_legacy_wrap
		do
			set_value (legacy_wrap)
		ensure
			value_set_with_legacy_wrap: value = legacy_wrap
		end

	set_clip
		do
			set_value (clip)
		ensure
			value_set_with_clip: value = clip
		end

	set_wrap
		do
			set_value (wrap)
		ensure
			value_set_with_wrap: value = wrap
		end


feature -- Status Report

	is_overflow_cell: BOOLEAN
		do
			Result := value = overflow_cell
		end

	is_legacy_wrap: BOOLEAN
		do
			Result := value = legacy_wrap
		end

	is_clip: BOOLEAN
		do
			Result := value = clip
		end

	is_wrap: BOOLEAN
		do
			Result := value = wrap
		end


	is_valid_value (a_value: INTEGER): BOOLEAN
			-- Can `a_value' be used in a `set_value' feature call?
		do
			Result := a_value = wrap_strategy_unspecified or else
			          a_value = overflow_cell or else
			          a_value = legacy_wrap or else
			          a_value = clip or else
			          a_value = wrap
		end

feature -- Eiffel to JSON

	to_json: JSON_STRING
		do
			if is_wrap then
				Result := "WRAP"
			elseif is_clip then
				Result := "CLIP"
			elseif is_legacy_wrap then
				Result := "LEGACY_WRAP"
			elseif is_overflow_cell then
				Result := "OVERFLOW_CELL"
			else
				Result := "WRAP_STRATEGY_UNSPECIFIED"
			end
		end
end
