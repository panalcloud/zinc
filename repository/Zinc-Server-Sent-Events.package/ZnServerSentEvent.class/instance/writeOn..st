writing
writeOn: stream
	"Write me in the text/event-stream format, UTF-8 encoded, on the binary stream and flush it.
	Lines end with LF; a blank line ends the event."

	| encoder |
	encoder := ZnCharacterWriteStream on: stream.
	comment ifNotNil: [
		self linesOf: comment asString do: [ :line | self writeField: '' value: line on: encoder ] ].
	event ifNotNil: [ self writeField: 'event' value: event asString on: encoder ].
	id ifNotNil: [ self writeField: 'id' value: id asString on: encoder ].
	retry ifNotNil: [ self writeField: 'retry' value: retry printString on: encoder ].
	data ifNotNil: [
		self linesOf: data asString do: [ :line | self writeField: 'data' value: line on: encoder ] ].
	encoder nextPut: Character lf; flush