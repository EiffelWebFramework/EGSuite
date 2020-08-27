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


feature -- Access

	number_format: detachable EG_NUMBER_FORMAT
			-- A format describing how number values should be represented to the user.

	background_color: detachable EG_COLOR
			-- The background color of the cell.

	background_color_style: detachable EG_COLOR_STYLE
			-- The background color of the cell. If backgroundColor is also set, this field takes precedence.

	borders: detachable EG_BORDERS
			-- The borders of the cell.

	padding: detachable EG_PADDING
			-- The padding of the cell.

	horizontal_alignment: detachable EG_HORIZONTAL_ALIGN
			-- The horizontal alignment of the value in the cell.

	vertical_alignment: detachable EG_VERTICAL_ALIGN
			-- The vertical alignment of the value in the cell. 						

	wrap_strategy: detachable EG_WRAP_STRATEGY
			-- The wrap strategy for the value in the cell.

	text_direction: detachable EG_TEXT_DIRECTION
			-- The direction of the text in the cell.

	text_format: detachable EG_TEXT_FORMAT
			-- The format of the text in the cell (unless overridden by a format run).

	hyperlink_display_type: detachable EG_HYPERLINK_DISPLAY_TYPE
			-- How a hyperlink, if it exists, should be displayed in the cell. 		

	text_rotation: detachable EG_TEXT_ROTATION
			-- The rotation applied to text in a cell

feature -- Change Element

	set_number_format (a_format: like number_format)
			-- Set `number_format` with `a_format`
		do
			number_format := a_format
		ensure
			number_format_set: number_format = a_format
		end

	set_background_color (a_bg_color: like background_color)
			-- Set `background_color` with `a_bg_color`
		do
			background_color := a_bg_color
		ensure
			background_color_set: background_color = a_bg_color
		end

	set_background_color_style (a_bg_color_style: like background_color_style)
			-- Set `background_color_style` with `a_bg_colot_style`.
		do
			background_color_style := a_bg_color_style
		ensure
			background_color_style_set: background_color_style = a_bg_color_style
		end

	set_borders (a_borders: like borders)
			-- Set `borders` with `a_borders`.
		do
			borders := a_borders
		ensure
			borders_set: borders = a_borders
		end

	set_padding (a_padding: like padding)
			-- Set `padding` with `a_padding`.
 		do
			padding := a_padding
		ensure
			padding_set: padding = a_padding
		end

	set_horizontal_alignment (ha: like horizontal_alignment)
			-- Set `horizontal_aligment` with `ha`.
		do
			horizontal_alignment := ha
		ensure
			horizontal_alignment_set: horizontal_alignment = ha
		end

	set_vertical_alignment (a_val: like vertical_alignment)
			-- Set `vertical_aligment` with `a_val`.
		do
			vertical_alignment := a_val
		ensure
			vertical_alignment_set: vertical_alignment = a_val
		end

	set_wrap_strategy (a_val: like wrap_strategy)
			-- Set `wrap_strategy` with `a_val`.
		do
			wrap_strategy := a_val
		ensure
			wrap_strategy_set: wrap_strategy = a_val
		end

	set_text_direction (a_val: like text_direction)
			-- Set `text_direction` with `a_val`
		do
			text_direction := a_val
		ensure
			text_direction_set: text_direction = a_val
		end

	set_text_format (a_val: like text_format)
			-- Set `text_format` with `a_val`.
		do
			text_format := a_val
		ensure
			text_format_set: text_format = a_val
		end

	set_hyperlink_display_type (a_val: like hyperlink_display_type)
			-- Set `hyperlink_display_type` with `a_val`
		do
			hyperlink_display_type := a_val
		ensure
			hyperlink_display_type_set: hyperlink_display_type = a_val
		end

	set_text_rotation (a_val: like text_rotation)
			-- Set `text_rotation` with `a_val`
		do
			text_rotation := a_val
		ensure
			text_rotation_set: text_rotation = a_val
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
			if attached number_format as l_number_format then
				Result.put (l_number_format.to_json, "numberFormat")
			end
			if attached background_color as l_bg then
				Result.put (l_bg.to_json, "backgroundColor")
			end
			if attached borders as lb then
				Result.put (lb.to_json, "borders")
			end
			if attached padding as l_padding then
				Result.put (l_padding.to_json, "padding")
			end
			if attached horizontal_alignment as l_ha then
				Result.put (l_ha.to_json, "horizontalAlignment")
			end
			if attached vertical_alignment as l_va then
				Result.put (l_va.to_json, "verticalAlignment")
			end
			if attached wrap_strategy as l_ws then
				Result.put (l_ws.to_json, "wrapStrategy")
			end
			if attached text_direction as l_td then
				Result.put (l_td.to_json, "textDirection")
			end
			if attached text_format as l_tf then
				Result.put (l_tf.to_json, "textFormat")
			end
			if attached background_color_style as l_bgs then
				Result.put (l_bgs.to_json, "backgroundColorStyle")
			end
			if attached hyperlink_display_type as l_hyper then
				Result.put (l_hyper.to_json, "hyperlinkDisplayType")
			end
			if attached text_rotation as l_rt then
				Result.put (l_rt.to_json, "textRotation")
			end

		end
end
