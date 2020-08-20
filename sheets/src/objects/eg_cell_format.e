note
	description: "[
		Object representing the format of a cell.
	
		{
		  "numberFormat": {
		    object (NumberFormat)
		  },
		  "backgroundColor": {
		    object (Color)
		  },
		  "backgroundColorStyle": {
		    object (ColorStyle)
		  },
		  "borders": {
		    object (Borders)
		  },
		  "padding": {
		    object (Padding)
		  },
		  "horizontalAlignment": enum (HorizontalAlign),
		  "verticalAlignment": enum (VerticalAlign),
		  "wrapStrategy": enum (WrapStrategy),
		  "textDirection": enum (TextDirection),
		  "textFormat": {
		    object (TextFormat)
		  },
		  "hyperlinkDisplayType": enum (HyperlinkDisplayType),
		  "textRotation": {
		    object (TextRotation)
		  }
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Cell Format", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/cells#CellFormat", "protocol=uri"

class
	EG_CELL_FORMAT

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			create background_color
			create background_color_style
			create padding
			create vertical_alignment
			create text_format
			create wrap_strategy
		end

feature -- Access

	number_format: detachable EG_NUMBER_FORMAT
			-- A format describing how number values should be represented to the user.

	background_color: EG_COLOR
			-- The background color of the cell.

	background_color_style: EG_COLOR_STYLE
			-- The background color of the cell. If backgroundColor is also set, this field takes precedence.

	borders: detachable EG_BORDERS
			-- The borders of the cell.

	padding: EG_PADDING
			-- The padding of the cell.

	horizontal_alignment: detachable EG_HORIZONTAL_ALIGN
			-- The horizontal alignment of the value in the cell.

	vertical_alignment: EG_VERTICAL_ALIGN
			-- The vertical alignment of the value in the cell. 						

	wrap_strategy: EG_WRAP_STRATEGY
			-- The wrap strategy for the value in the cell.

	text_direction: detachable EG_TEXT_DIRECTION
			-- The direction of the text in the cell.

	text_format: EG_TEXT_FORMAT
			-- The format of the text in the cell (unless overridden by a format run).

	hyperlink_display_type: detachable EG_HYPERLINK_DISPLAY_TYPE
			-- How a hyperlink, if it exists, should be displayed in the cell. 		

	text_rotation: detachable EG_TEXT_ROTATION
			-- The rotation applied to text in a cell

feature -- Change Element

	set_number_format (a_format: EG_NUMBER_FORMAT)
		do
			number_format := a_format
		end

	set_background_color (a_bg_color: EG_COLOR)
		do
			background_color := a_bg_color
		end

	set_background_color_style (a_bg_color_style: EG_COLOR_STYLE)
		do
			background_color_style := a_bg_color_style
		end

	set_borders (a_borders: EG_BORDERS)
		do
			borders := a_borders
		end

	set_padding (a_padding: EG_PADDING)
		do
			padding := a_padding
		end

	set_horizontal_alignment (ha: EG_HORIZONTAL_ALIGN)
		do
			horizontal_alignment := ha
		end

	set_vertical_alignment (a_val: EG_VERTICAL_ALIGN)
		do
			vertical_alignment := a_val
		end

	set_wrap_strategy (a_val: EG_WRAP_STRATEGY)
		do
			wrap_strategy := a_val
		end

	set_text_direction (a_val: EG_TEXT_DIRECTION)
		do
			text_direction := a_val
		end

	set_text_format (a_val: EG_TEXT_FORMAT)
		do
			text_format := a_val
		end

	set_hyperlink_display_type (a_val: EG_HYPERLINK_DISPLAY_TYPE)
		do
			hyperlink_display_type := a_val
		end

	set_text_rotation (a_val: EG_TEXT_ROTATION)
		do
			text_rotation := a_val
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
--	{
--		  "numberFormat": {
--		    object (NumberFormat)
--		  },
--		  "backgroundColor": {
--		    object (Color)
--		  },
--		  "backgroundColorStyle": {
--		    object (ColorStyle)
--		  },
--		  "borders": {
--		    object (Borders)
--		  },
--		  "padding": {
--		    object (Padding)
--		  },
--		  "horizontalAlignment": enum (HorizontalAlign),
--		  "verticalAlignment": enum (VerticalAlign),
--		  "wrapStrategy": enum (WrapStrategy),
--		  "textDirection": enum (TextDirection),
--		  "textFormat": {
--		    object (TextFormat)
--		  },
--		  "hyperlinkDisplayType": enum (HyperlinkDisplayType),
--		  "textRotation": {
--		    object (TextRotation)
--		  }
--		}

		do
			create Result.make_empty
				-- TODO
			Result.put (Void, "numberFormat")
			Result.put (background_color.to_json, "backgroundColor")
			Result.put (background_color_style.to_json, "backgroundColorStyle")
		end
end
