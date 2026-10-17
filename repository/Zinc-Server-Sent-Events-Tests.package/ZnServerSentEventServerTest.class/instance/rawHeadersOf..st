private
rawHeadersOf: path
	"Answer the response headers exactly as the server wrote them; ZnClient adds headers of its own"

	| socketStream lineReader lines |
	socketStream := ZnNetworkingUtils socketStreamToUrl: server localUrl.
	[ socketStream
		nextPutAll: ('GET /', path, ' HTTP/1.1', String crlf, 'Host: localhost', String crlf, String crlf) asByteArray;
		flush.
	  lineReader := ZnLineReader on: socketStream.
	  lines := OrderedCollection new.
	  [ lines isEmpty or: [ lines last notEmpty ] ] whileTrue: [ lines add: lineReader nextLine ] ]
		ensure: [ socketStream close ].
	^ ZnHeaders readFrom: ((String crlf join: lines allButFirst), String crlf) readStream