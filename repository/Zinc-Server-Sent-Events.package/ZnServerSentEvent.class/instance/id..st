accessing
id: idString
	"An empty id resets the client's last event id"

	self checkSingleLine: idString named: 'id'.
	id := idString