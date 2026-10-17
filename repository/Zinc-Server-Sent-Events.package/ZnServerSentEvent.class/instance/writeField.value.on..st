private
writeField: fieldName value: string on: stream
	"A client removes one space after the colon, so always write one before a value"

	stream nextPutAll: fieldName; nextPut: $:.
	string isEmpty ifFalse: [ stream nextPut: $ ; nextPutAll: string ].
	stream nextPut: Character lf