note
	description: "[
		A sheet in a spreadsheet.



		  "properties": {
		    object (SheetProperties)
		  },
		  "data": [
		    {
		      object (GridData)
		    }
		  ],
		  "merges": [
		    {
		      object (GridRange)
		    }
		  ],
		  "conditionalFormats": [
		    {
		      object (ConditionalFormatRule)
		    }
		  ],
		  "filterViews": [
		    {
		      object (FilterView)
		    }
		  ],
		  "protectedRanges": [
		    {
		      object (ProtectedRange)
		    }
		  ],
		  "basicFilter": {
		    object (BasicFilter)
		  },
		  "charts": [
		    {
		      object (EmbeddedChart)
		    }
		  ],
		  "bandedRanges": [
		    {
		      object (BandedRange)
		    }
		  ],
		  "developerMetadata": [
		    {
		      object (DeveloperMetadata)
		    }
		  ],
		  "rowGroups": [
		    {
		      object (DimensionGroup)
		    }
		  ],
		  "columnGroups": [
		    {
		      object (DimensionGroup)
		    }
		  ],
		  "slicers": [
		    {
		      object (Slicer)
		    }
		  ]
		}
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Sheet", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#sheet", "protocol=uri"

class
	EG_SHEET

inherit

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Access

	default_create
		do
			create properties
		end

feature -- Access

	properties: EG_SHEET_PROPERTIES
			-- The properties of the sheet.

	data: detachable LIST [EG_GRID_DATA]
			-- Data in the grid, if this is a grid sheet.

	merges: detachable LIST [EG_GRID_RANGE]
			-- The ranges that are merged together.

	conditional_formats: detachable LIST [EG_CONDITIONAL_FORMAT_RULE]
			-- The conditional format rules in this sheet.

	filter_views: detachable LIST [EG_FILTER_VIEW]
			-- The filter views in this sheet.

	protected_ranges: detachable LIST [EG_PROTECTED_RANGE]
			-- The protected ranges in this sheet.

	basic_filter: detachable EG_BASIC_FILTER
			-- The filter on this sheet, if any.	

	charts: detachable LIST [EG_EMBEDDED_CHART]
			-- The specifications of every chart on this sheet.

	banded_ranges: detachable LIST [EG_BANDED_RANGE]
			-- The banded (alternating colors) ranges on this sheet.

	developer_metadata: detachable LIST [EG_DEVELOPER_METADATA]
			-- The developer metaata on this sheet.

	raw_groups: detachable LIST [EG_DIMENSION_GROUP]
			-- All row groups on this sheet, ordered by increasing range start index, then by group depth.

	column_groups: detachable LIST [EG_DIMENSION_GROUP]
			-- All column groups on this sheet, ordered by increasing range start index, then by group depth.

	slicers: detachable LIST [EG_SLICER]
			-- The slicers on this sheet.		
end
