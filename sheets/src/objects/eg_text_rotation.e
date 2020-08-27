note
	description: "[
	The rotation applied to text in a cell. 
	
	JSON representation

	{

	  // Union field type can be only one of the following:
	  "angle": integer,
	  "vertical": boolean
	  // End of list of possible types for union field type.
	}

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_TEXT_ROTATION


feature -- Access

	angle: INTEGER
		-- The angle between the standard orientation and the desired orientation. Measured in degrees. Valid values are between -90 and 90.
		-- Positive angles are angled upwards, negative are angled downwards.
		-- Note: For LTR text direction positive angles are in the counterclockwise direction, whereas for RTL they are in the clockwise direction

	vertical: BOOLEAN
		-- If true, text reads top to bottom, but the orientation of individual characters is unchanged. For example:


feature -- Status

	is_vertical: BOOLEAN
			-- is Field type set to vertical?

	is_angle: BOOLEAN
			-- is Field type set to angle?


feature -- Element Change

	set_angle (a_angle: like angle)
		do
			is_vertical := False
			is_angle := True
			angle := a_angle
		ensure
			angle_set: angle = a_angle
		end

	set_vertical (a_val: like vertical)
		do
			is_vertical := True
			is_angle := False
			vertical := a_val
		ensure
			vertical_set: vertical = a_val
		end


feature -- Eiffel to JSON

	to_json: JSON_OBJECT
		do
			create Result.make_empty
			if is_angle then
				Result.put (create {JSON_NUMBER}.make_integer (angle), "angle")
			end
			if is_vertical then
				Result.put (create {JSON_BOOLEAN}.make (vertical), "vertical")
			end
		end
end
