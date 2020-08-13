note
	description: "Base class for error gestion"
	author: "Philippe Gachoud"
	date: "$Date$"
	revision: "$Revision$"

class
	FALLIBLE

inherit
	LOGGABLE
		redefine
			default_create,
			out
		end


feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create warnings.make
		end

	make_from_separate (other: separate like Current)
		do
--			Precursor (other)
			create warnings.make
			if attached other.last_error as l_e then
				create last_error.make_from_separate (l_e)
			end
			if attached other.last_success_message as l_e then
				create last_success_message.make_from_separate (l_e)
			end
		end

feature -- Access

	warnings: LINKED_LIST[STRING]

	last_error: detachable EG_SHEET_ERROR
		-- Last error

	last_success_message: detachable STRING
		-- If any


feature -- Status report

	has_error: BOOLEAN
			-- Based on last_error
		do
			Result := last_error /= Void
		end

	has_warnings: BOOLEAN
		do
			Result := warnings.is_empty
		end

	is_valid: BOOLEAN
		do
			Result := not has_error
		end

feature -- Output

	out: STRING
		do
			Result := generating_type.out + ": Fallible, error_status:" + has_error.out
			if attached last_error as l_err then
				Result.append (l_err.out)
			end
			if attached last_success_message as l_msg then
				Result.append (l_msg)
			end
		end


feature -- Status setting

	set_last_error_from_fallible (o: FALLIBLE)
		require
			attached o.last_error
		do
			last_error := o.last_error
			last_success_message := Void
		ensure
			attached o.last_error implies last_success_message = Void
		end

	set_last_error_from_fallible_sep (other: separate FALLIBLE)
		require
			attached other.last_error
		do
			if attached other.last_error as l_le then
				last_error := {EG_SHEET_ERROR}.error_from_separate (l_le)
				last_success_message := Void
			else
				last_error := Void
			end
		ensure
			attached other.last_error implies last_success_message = Void
		end

	set_last_error (an_error: like last_error)
		do
			last_error:= an_error
			if attached an_error then
				last_success_message := Void
				logger.write_warning ("Class: " + generating_type.out + " set_last_error-> Error setted: " + an_error.message)
			end
		ensure
			attached an_error implies last_success_message = Void
			has_error
		end

	set_last_success_message_from_fallible (o: attached like Current)
		require
			attached o.last_success_message
		do
			last_success_message := o.last_success_message
			last_error := Void
		ensure
			attached o.last_success_message implies last_error = Void
		end

	set_last_success_message (a_msg: attached like last_success_message)
		do
			last_success_message := a_msg
			last_error := Void
		ensure
			attached a_msg implies last_error = Void
		end

	wipe_last_error
			-- Once you consider having treated it
		do
			last_error := Void
		ensure
			last_error = Void
		end

	wipe_last_success_message
		do
			last_success_message := Void
		ensure
			last_success_message = Void
		end

	extend_warnings (v: like warnings.item)
		do
			logger.write_warning (v)
			warnings.extend (v)
		end

invariant
	never_both_attached: not (attached last_error and attached last_success_message)
	is_valid implies not has_error
	has_error implies not is_valid
end
