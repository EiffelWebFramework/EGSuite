note
	description: "[
		A filter view.
	
	{
	  "filterViewId": integer,
	  "title": string,
	  "range": {
	    object (GridRange)
	  },
	  "namedRangeId": string,
	  "sortSpecs": [
	    {
	      object (SortSpec)
	    }
	  ],
	  "criteria": {
	    string: {
	      object(FilterCriteria)
	    },
	    ...
	  }
	}


	
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Filter View", "src=https://developers.google.com/sheets/api/reference/rest/v4/spreadsheets/sheets#filterview", "protocol=uri"
class
	EG_FILTER_VIEW

end
