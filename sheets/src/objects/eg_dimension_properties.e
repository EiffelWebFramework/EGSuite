note
	description: "[
	Properties about a dimension. 
	
	{
	  "hiddenByFilter": boolean,
	  "hiddenByUser": boolean,
	  "pixelSize": integer,
	  "developerMetadata": [
	    {
	      object (DeveloperMetadata)
	    }
	  ]
	}

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_DIMENSION_PROPERTIES


feature -- Access

	hidden_by_filter: BOOLEAN
			-- True if this dimension is being filtered. This field is read-only.

	hidden_by_user: BOOLEAN
			-- True if this dimension is explicitly hidden.

	pixel_size: INTEGER
			-- The height (if a row) or width (if a column) of the dimension in pixels.

	developer_metadata: detachable LIST [EG_DEVELOPER_METADATA]
			-- The developer metadata associated with a single row or column.

feature -- Status Report

	is_hidden_by_filter_set: BOOLEAN
			-- Use to set the value once.

feature -- Element Change

	set_hidden_by_filter (a_val: like hidden_by_filter)
			-- Set `hidden_by_filter` with `a_val`.
		require
			not_set: not is_hidden_by_filter_set
		do
			is_hidden_by_filter_set := True
			hidden_by_filter := a_val
		ensure
			hidden_by_filter_set: hidden_by_filter = a_val
			is_hidden_by_filter_set: is_hidden_by_filter_set
		end

	set_hidden_by_user (a_val: like hidden_by_user)
			-- Set `hidden_by_user` with `a_val`.
		do
			hidden_by_user := a_val
		ensure
			hidden_by_user_set: hidden_by_user = a_val
		end

	set_pixel_size (a_size: like pixel_size)
			-- Set `pixel_size` with `a_size`.
		do
			pixel_size := a_size
		ensure
			pixel_size_set: pixel_size = a_size
		end

	force_developer_metadata (a_metadata: EG_DEVELOPER_METADATA)
			-- Add an item `a_metadata` to the list `developer_metadata`.
		local
			l_developer_metadata: like developer_metadata
		do
			l_developer_metadata := developer_metadata
			if l_developer_metadata /= Void then
				l_developer_metadata.force (a_metadata)
			else
				create {ARRAYED_LIST [EG_DEVELOPER_METADATA]}l_developer_metadata.make (5)
				l_developer_metadata.force (a_metadata)
			end
			developer_metadata := l_developer_metadata
		end

feature -- Eiffel to JSON

	to_json: JSON_OBJECT
			-- JSon representtion of the current object.
		do
			create Result.make
		end
end
