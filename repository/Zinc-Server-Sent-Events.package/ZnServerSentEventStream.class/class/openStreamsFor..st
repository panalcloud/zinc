accessing
openStreamsFor: aServer
	^ self openStreams select: [ :each | each server == aServer ]