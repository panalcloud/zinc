reading
upToEnd
	"Answer all events until the stream ends"

	^ Array streamContents: [ :out | self do: [ :each | out nextPut: each ] ]