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

feature -- Access

	properties: detachable EG_SHEET_PROPERTIES
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

	set_data (a_data: like data)
		do
			data := a_data
		ensure
			data_set: data = a_data
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

	set_merges (a_merges: like merges)
		do
			merges := a_merges
		ensure
			merges_set: merges = a_merges
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

	set_conditional_formats (a_conditional_formats: like conditional_formats)
		do
			conditional_formats := a_conditional_formats
		ensure
			conditional_formats_set: conditional_formats = a_conditional_formats
		end

	force_filter_views	(a_item: EG_FILTER_VIEW)
			-- Add an item `a_item` to the list `fitler_views`.
		local
			l_filter_views: like filter_views
		do
			l_filter_views := filter_views
			if l_filter_views /= Void then
				l_filter_views.force (a_item)
			else
				create {ARRAYED_LIST [EG_FILTER_VIEW]} l_filter_views.make (5)
				l_filter_views.force (a_item)
			end
			filter_views := l_filter_views
		end

	set_filter_views (a_filter_views: like filter_views)
		do
			filter_views := a_filter_views
		ensure
			filter_views_set: filter_views = a_filter_views
		end

	force_protected_ranges (a_item: EG_PROTECTED_RANGE)
			-- Add an item `a_item` to the list `protected_ranges`.
		local
			l_protected_ranges: like protected_ranges
		do
			l_protected_ranges := protected_ranges
			if l_protected_ranges /= Void then
				l_protected_ranges.force (a_item)
			else
				create {ARRAYED_LIST [EG_PROTECTED_RANGE]} l_protected_ranges.make (5)
				l_protected_ranges.force (a_item)
			end
			protected_ranges := l_protected_ranges
		end

	set_protected_ranges (a_protected_ranges: like protected_ranges)
		do
			protected_ranges := a_protected_ranges
		ensure
			protected_ranges_set: protected_ranges = a_protected_ranges
		end

	set_basic_filter (a_filter: like basic_filter)
			-- Set `basic_filter` with `a_filter`.
		do
			basic_filter := a_filter
		ensure
			basic_filter_set: basic_filter = a_filter
		end

	force_charts (a_item: EG_EMBEDDED_CHART)
			-- Add an item `a_item` to the list `charts`.
		local
			l_charts: like charts
		do
			l_charts := charts
			if l_charts /= Void then
				l_charts.force (a_item)
			else
				create {ARRAYED_LIST [EG_EMBEDDED_CHART]} l_charts.make (5)
				l_charts.force (a_item)
			end
			charts := l_charts
		end

	set_charts (a_charts: like charts)
		do
			charts := a_charts
		ensure
			charts_set: charts = a_charts
		end

	force_banded_ranges (a_item: EG_BANDED_RANGE)
			-- Add an item `a_item` to the list of `banded_ranges`.
		local
			l_banded_ranges: like banded_ranges
		do
			l_banded_ranges := banded_ranges
			if l_banded_ranges /= Void then
				l_banded_ranges.force (a_item)
			else
				create {ARRAYED_LIST [EG_BANDED_RANGE]} l_banded_ranges.make (5)
				l_banded_ranges.force (a_item)
			end
			banded_ranges := l_banded_ranges
		end

	set_banded_ranges (a_banded_ranges: like banded_ranges)
		do
			banded_ranges := a_banded_ranges
		ensure
			banded_ranges_set: banded_ranges = a_banded_ranges
		end

	force_developer_metadata (a_item: EG_DEVELOPER_METADATA)
			-- Add an item `a_item` to the list of `developer_metadata`.
		local
			l_developer_metadata: like developer_metadata
		do
			l_developer_metadata := developer_metadata
			if l_developer_metadata /= Void then
				l_developer_metadata.force (a_item)
			else
				create {ARRAYED_LIST [EG_DEVELOPER_METADATA]} l_developer_metadata.make (5)
				l_developer_metadata.force (a_item)
			end
			developer_metadata := l_developer_metadata
		end

	set_developer_metadata (a_developer_metadata: like developer_metadata)
		do
			developer_metadata := a_developer_metadata
		ensure
			developer_metadata_set: developer_metadata = a_developer_metadata
		end

	force_raw_groups (a_item: EG_DIMENSION_GROUP)
			-- Add an item `a_item` to the list of `raw_groups`.
		local
			l_raw_groups: like raw_groups
		do
			l_raw_groups := raw_groups
			if l_raw_groups /= Void then
				l_raw_groups.force (a_item)
			else
				create {ARRAYED_LIST [EG_DIMENSION_GROUP]} l_raw_groups.make (5)
				l_raw_groups.force (a_item)
			end
			raw_groups := l_raw_groups
		end

	set_raw_groups (a_raw_groups: like raw_groups)
		do
			raw_groups := a_raw_groups
		ensure
			raw_groups_set: raw_groups = a_raw_groups
		end

	force_column_groups (a_item: EG_DIMENSION_GROUP)
			-- Add an item `a_item` to the list of `column_groups`.
		local
			l_column_groups: like column_groups
		do
			l_column_groups := column_groups
			if l_column_groups /= Void then
				l_column_groups.force (a_item)
			else
				create {ARRAYED_LIST [EG_DIMENSION_GROUP]} l_column_groups.make (5)
				l_column_groups.force (a_item)
			end
			column_groups := l_column_groups
		end

	set_column_groups (a_column_groups: like column_groups)
		do
			column_groups := a_column_groups
		ensure
			column_groups_set: column_groups = a_column_groups
		end

	force_slicers (a_item: EG_SLICER)
			-- -- Add an item `a_item` to the list of `slicers`.
		local
			l_sclicers: like slicers
		do
			l_sclicers := slicers
			if l_sclicers /= Void then
				l_sclicers.force (a_item)
			else
				create {ARRAYED_LIST [EG_SLICER]} l_sclicers.make (5)
				l_sclicers.force (a_item)
			end
			slicers := l_sclicers
		end

	set_slicers (a_slicers: like slicers)
		do
			slicers := a_slicers
		ensure
			slicers_set: slicers = a_slicers
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- Json representation of current object.
		local
			j_array: JSON_ARRAY
		do
			create Result.make_empty
			if attached properties as l_properties then
				Result.put (l_properties.to_json, "properties")
			end
			if attached data as l_data then
				create j_array.make (l_data.count)
				across l_data as ic loop
					j_array.add (ic.item.to_json)
				end
				Result.put (j_array, "data")
			end

		end

--		  "data": [
--		    {
--		      object (GridData)
--		    }
--		  ],
--		  "merges": [
--		    {
--		      object (GridRange)
--		    }
--		  ],
--		  "conditionalFormats": [
--		    {
--		      object (ConditionalFormatRule)
--		    }
--		  ],
--		  "filterViews": [
--		    {
--		      object (FilterView)
--		    }
--		  ],
--		  "protectedRanges": [
--		    {
--		      object (ProtectedRange)
--		    }
--		  ],
--		  "basicFilter": {
--		    object (BasicFilter)
--		  },
--		  "charts": [
--		    {
--		      object (EmbeddedChart)
--		    }
--		  ],
--		  "bandedRanges": [
--		    {
--		      object (BandedRange)
--		    }
--		  ],
--		  "developerMetadata": [
--		    {
--		      object (DeveloperMetadata)
--		    }
--		  ],
--		  "rowGroups": [
--		    {
--		      object (DimensionGroup)
--		    }
--		  ],
--		  "columnGroups": [
--		    {
--		      object (DimensionGroup)
--		    }
--		  ],
--		  "slicers": [
--		    {
--		      object (Slicer)
--		    }
--		  ]
--		}


end
