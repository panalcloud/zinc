accessing
openStreams
	"All open streams in this image, for monitoring"

	^ openStreamsLock critical: [ openStreams asArray ]