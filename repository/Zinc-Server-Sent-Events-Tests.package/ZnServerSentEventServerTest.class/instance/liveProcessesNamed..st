private
liveProcessesNamed: aString
	^ Process allSubInstances select: [ :each | each isTerminated not and: [ each name = aString ] ]