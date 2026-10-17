writing
writeOn: stream
	self ensureEventStreamHeaders.
	super writeOn: stream