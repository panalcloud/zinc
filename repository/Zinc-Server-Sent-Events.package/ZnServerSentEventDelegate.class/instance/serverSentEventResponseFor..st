accessing
serverSentEventResponseFor: request
	"Create and return a proper Server-Sent Events response for request.
	I pass my handler to the response as a continuation.
	After the response is written out, the handler will be sent #runEventStream: 
	with a ZnServerSentEventStream, or #run: with the open HTTP connection."
	
	^ ZnServerSentEventResponse request: request handler: self handler