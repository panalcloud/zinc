private
unregister: aStream
	openStreamsLock critical: [ openStreams remove: aStream ifAbsent: [ ] ]