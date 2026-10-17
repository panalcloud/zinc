private
dispatch
	"A blank line: answer the collected event, or nil when no data was collected.
	The data loses its last LF; the event type is reset either way; the last event id stays."

	| text type |
	text := data contents.
	type := eventType.
	data := WriteStream on: (String new: 80).
	eventType := nil.
	text isEmpty ifTrue: [ ^ nil ].
	^ ZnServerSentEvent new
		event: (type ifNotNil: [ type ifEmpty: [ nil ] ]);
		id: lastEventId;
		data: text allButLast;
		yourself