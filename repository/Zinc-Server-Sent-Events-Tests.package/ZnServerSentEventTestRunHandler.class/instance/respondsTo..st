testing
respondsTo: aSymbol
	"Hide the inherited new protocol, so the response falls back to #run:"

	^ aSymbol ~= #runEventStream: and: [ super respondsTo: aSymbol ]