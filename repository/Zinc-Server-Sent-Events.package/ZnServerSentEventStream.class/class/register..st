private
register: aStream
	openStreamsLock critical: [ openStreams add: aStream ]