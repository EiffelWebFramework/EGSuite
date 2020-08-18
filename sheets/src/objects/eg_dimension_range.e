note
	description: "[
		A range along a single dimension on a sheet. All indexes are zero-based. Indexes are half open: the start index is inclusive and the end index is exclusive. 
		Missing indexes indicate the range is unbounded on that side.

		{
		  "sheetId": integer,
		  "dimension": enum (Dimension),
		  "startIndex": integer,
		  "endIndex": integer
		}

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Dimension Range", "src=https://developers.google.com/sheets/api/reference/rest/v4/DimensionRange", "protocol=uri"
class
	EG_DIMENSION_RANGE

end
