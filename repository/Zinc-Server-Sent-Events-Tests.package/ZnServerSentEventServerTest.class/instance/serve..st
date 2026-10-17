private
serve: aHandler
	"Answer every request with an event stream run by aHandler"

	server delegate: (ZnValueDelegate with: [ :request |
		ZnServerSentEventResponse request: request handler: aHandler ])