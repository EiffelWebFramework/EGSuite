Eiffel API for Google Sheets API
https://developers.google.com/sheets/api/reference/rest
https://help.form.io/integrations/googledrive/



OAuth2.0 Client credentials
To begin, obtain OAuth 2.0 client credentials from the [Browser Quickstart](https://developers.google.com/sheets/api/quickstart/js) and enable the credentials.


  - EG_SHEETS_I -- it's an interface where we work with Eiffel Objects
  - EG_SHEETS_API -- It's the low level interface that sends and receives HTTP messages..
  - EG_SHEETS_JSON -- it's the implementation where we map from the HTTP messages encoded in JSON format to the Eiffel side. (and vice versa).

Then in the object cluster we have the Eiffel objects representing the API domain.