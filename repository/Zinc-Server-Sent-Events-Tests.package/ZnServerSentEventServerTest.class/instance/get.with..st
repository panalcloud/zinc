private
get: path with: setupBlock
	"Open a stream and answer the response; its entity stream stays open until tearDown"

	| client |
	client := ZnClient new.
	clients add: client.
	client
		url: server localUrl;
		addPath: path;
		streaming: true;
		timeout: 5.
	setupBlock value: client.
	^ client get; response