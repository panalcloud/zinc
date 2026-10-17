private
processLine: line
	"Answer an event when line ends one, else nil"

	| colon |
	line isEmpty ifTrue: [ ^ self dispatch ].
	line first = $: ifTrue: [
		commentHandler ifNotNil: [ commentHandler value: (self valueOf: line allButFirst) ].
		^ nil ].
	colon := line indexOf: $:.
	colon = 0
		ifTrue: [ self processField: line value: '' ]
		ifFalse: [ self processField: (line copyFrom: 1 to: colon - 1) value: (self valueOf: (line copyFrom: colon + 1 to: line size)) ].
	^ nil