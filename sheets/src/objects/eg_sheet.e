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


feature -- Element Change

	set_properties (a_properties: like properties)
			-- -- Set `properties` with `a_properties`.
		do
			properties := a_properties
		ensure
			properties_set: properties = a_properties
		end

	force_data (a_data: EG_GRID_DATA)
			-- Add an item `a_data` to the list `data`.
		local
			l_data: like data
		do
			l_data := data
			if l_data /= Void then
				l_data.force (a_data)
			else
				create {ARRAYED_LIST [EG_GRID_DATA]}l_data.make (5)
				l_data.force (a_data)
			end
			data := l_data
		end

	force_merges (a_merge: EG_GRID_RANGE)
			-- Add an item `a_merge` to the list `merges`.
		local
			l_merges: like merges
		do
			l_merges := merges
			if l_merges /= Void then
				l_merges.force (a_merge)
			else
				create {ARRAYED_LIST [EG_GRID_RANGE]}l_merges.make (5)
				l_merges.force (a_merge)
			end
			merges := l_merges
		end

	force_conditional_formats (a_item: EG_CONDITIONAL_FORMAT_RULE)
			-- Add an item `a_item` to the list `conditional_formats`.
		local
			l_conditional_formats: like conditional_formats
		do
			l_conditional_formats := conditional_formats
			if l_conditional_formats /= Void then
				l_conditional_formats.force (a_item)
			else
				create {ARRAYED_LIST [EG_CONDITIONAL_FORMAT_RULE]}l_conditional_formats.make (5)
				l_conditional_formats.force (a_item)
			end
			conditional_formats := l_conditional_formats
		end
end
