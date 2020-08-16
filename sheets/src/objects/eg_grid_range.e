note
	description: "[
		A range on a sheet. All indexes are zero-based. Indexes are half open, i.e. the start index is inclusive and the end index is exclusive -- [startIndex, endIndex). Missing indexes indicate the range is unbounded on that side.

		For example, if "Sheet1" is sheet ID 0, then:

		Sheet1!A1:A1 == sheetId: 0, startRowIndex: 0, endRowIndex: 1, startColumnIndex: 0, endColumnIndex: 1

		Sheet1!A3:B4 == sheetId: 0, startRowIndex: 2, endRowIndex: 4, startColumnIndex: 0, endColumnIndex: 2

		Sheet1!A:B == sheetId: 0, startColumnIndex: 0, endColumnIndex: 2

		Sheet1!A5:B == sheetId: 0, startRowIndex: 4, startColumnIndex: 0, endColumnIndex: 2

		Sheet1 == sheetId:0

		The start index must always be less than or equal to the end index. If the start index equals the end index, then the range is empty. Empty ranges are typically not meaningful and are usually rendered in the UI as #REF!

	{
	  "sheetId": integer,
	  "startRowIndex": integer,
	  "endRowIndex": integer,
	  "startColumnIndex": integer,
	  "endColumnIndex": integer
	}	
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Grid Range", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/other#gridrange", "protocol=uri"
class
	EG_GRID_RANGE


feature -- Access
		-- Note maybe we can use NATURAL instead of INTEGER.

	sheet_id: INTEGER
			-- The sheet this range is on.

	start_row_index: INTEGER
			-- The start row (inclusive) of the range, or not set if unbounded.

	end_row_index: INTEGER
			-- The end row (exclusive) of the range, or not set if unbounded.

	start_column_index: INTEGER
			-- The start column (inclusive) of the range, or not set if unbounded.

	end_column_index: INTEGER
			-- The end column (exclusive) of the range, or not set if unbounded.


feature -- Element Change

	set_sheet_id (a_id: like sheet_id)
		do
			sheet_id := a_id
		ensure
			sheet_id_set: sheet_id = a_id
		end

	set_start_row_inder (a_index: like start_row_index)
		do
			start_row_index := a_index
		ensure
			start_column_index_set: start_row_index = a_index
		end

	set_end_row_index (a_index: like end_row_index)
		do
			end_row_index := a_index
		ensure
			end_row_index_set: end_row_index = a_index
		end

	set_start_column_index (a_index: like start_column_index)
		do
			start_column_index := a_index
		ensure
			start_column_index_set: start_column_index = a_index
		end

	set_end_column_index (a_index: like end_column_index)
		do
			end_column_index := a_index
		ensure
			end_column_index_set: end_column_index = a_index
		end


end
