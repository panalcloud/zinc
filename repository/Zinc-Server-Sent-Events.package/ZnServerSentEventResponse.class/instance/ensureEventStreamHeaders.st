private
ensureEventStreamHeaders
	"Whatever way I was built: the event stream content type with charset, no caching,
	no proxy buffering (unless the caller set those two), and no content length"

	self setContentType: self class eventStreamMimeType.
	(self headers includesKey: 'Cache-Control') ifFalse: [ self headers at: 'Cache-Control' put: 'no-cache' ].
	(self headers includesKey: 'X-Accel-Buffering') ifFalse: [ self headers at: 'X-Accel-Buffering' put: 'no' ].
	(self headers includesKey: 'Content-Length') ifTrue: [ self headers removeKey: 'Content-Length' ]