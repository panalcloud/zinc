instance creation
request: aRequest handler: aHandler
	"A 200 OK event stream answering aRequest. After the headers are written, aHandler is sent
	#runEventStream: with a ZnServerSentEventStream, or #run: with the raw connection when it does not understand the former."

	^ self new
		statusLine: ZnStatusLine ok;
		headers: ZnHeaders defaultResponseHeaders;
		request: aRequest;
		handler: aHandler;
		setContentType: self eventStreamMimeType;
		yourself