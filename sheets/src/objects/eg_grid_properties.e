note
	description: "[
	Properties of a grid.
	
	{
	  "rowCount": integer,
	  "columnCount": integer,
	  "frozenRowCount": integer,
	  "frozenColumnCount": integer,
	  "hideGridlines": boolean,
	  "rowGroupControlAfter": boolean,
	  "columnGroupControlAfter": boolean
	}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Grid Properties", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#gridproperties", "protocol=uri"

class
	EG_GRID_PROPERTIES


feature -- Access

	row_count: INTEGER assign set_row_count
			-- The number of rows in the grid.

	column_count: INTEGER assign set_column_count
			-- The number of columns in the grid.

	frozen_row_count: INTEGER assign set_frozen_row_count
			-- The number of rows that are frozen in the grid.

	frozen_column_count: INTEGER assign set_frozen_column_count
			-- The number of columns that are frozen in the grid.

	hide_grid_lines: BOOLEAN assign set_hide_grid_lines
			-- `hide_grid_lines'

	row_group_control_after: BOOLEAN assign set_row_group_control_after
			-- True if the row grouping control toggle is shown after the group.

	column_group_control_after: BOOLEAN assign set_column_group_control_after
			-- True if the column grouping control toggle is shown after the group.


feature -- Element change

	set_frozen_row_count (a_frozen_row_count: like frozen_row_count)
			-- Assign `frozen_row_count' with `a_frozen_row_count'.
		do
			frozen_row_count := a_frozen_row_count
		ensure
			frozen_row_count_assigned: frozen_row_count = a_frozen_row_count
		end

	set_frozen_column_count (a_frozen_column_count: like frozen_column_count)
			-- Assign `frozen_column_count' with `a_frozen_column_count'.
		do
			frozen_column_count := a_frozen_column_count
		ensure
			frozen_column_count_assigned: frozen_column_count = a_frozen_column_count
		end

	set_hide_grid_lines (a_hide_grid_lines: like hide_grid_lines)
			-- Assign `hide_grid_lines' with `a_hide_grid_lines'.
		do
			hide_grid_lines := a_hide_grid_lines
		ensure
			hide_grid_lines_assigned: hide_grid_lines = a_hide_grid_lines
		end

	set_row_group_control_after (a_row_group_control_after: like row_group_control_after)
			-- Assign `row_group_control_after' with `a_row_group_control_after'.
		do
			row_group_control_after := a_row_group_control_after
		ensure
			row_group_control_after_assigned: row_group_control_after = a_row_group_control_after
		end

	set_column_group_control_after (a_column_group_control_after: like column_group_control_after)
			-- Assign `column_group_control_after' with `a_column_group_control_after'.
		do
			column_group_control_after := a_column_group_control_after
		ensure
			column_group_control_after_assigned: column_group_control_after = a_column_group_control_after
		end

	set_column_count (a_column_count: like column_count)
			-- Assign `column_count' with `a_column_count'.
		do
			column_count := a_column_count
		ensure
			column_count_assigned: column_count = a_column_count
		end

	set_row_count (a_row_count: like row_count)
			-- Assign `row_count' with `a_row_count'.
		do
			row_count := a_row_count
		ensure
			row_count_assigned: row_count = a_row_count
		end

end
