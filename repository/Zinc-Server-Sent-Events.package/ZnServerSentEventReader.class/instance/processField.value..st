private
processField: field value: value
	"Unknown fields are ignored. An id or event type containing NUL is ignored (ZnServerSentEvent cannot hold one)."

	field = 'data' ifTrue: [ ^ data nextPutAll: value; nextPut: Character lf ].
	field = 'event' ifTrue: [ ^ (value includes: Character null) ifFalse: [ eventType := value ] ].
	field = 'id' ifTrue: [ ^ (value includes: Character null) ifFalse: [ lastEventId := value ] ].
	field = 'retry' ifTrue: [
		^ (value notEmpty and: [ value allSatisfy: [ :each | each between: $0 and: $9 ] ])
			ifTrue: [ retry := value asInteger ] ]