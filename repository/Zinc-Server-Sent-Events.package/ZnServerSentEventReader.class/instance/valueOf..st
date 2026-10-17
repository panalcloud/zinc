private
valueOf: string
	"One space after the colon is not part of the value"

	^ (string notEmpty and: [ string first = $  ])
		ifTrue: [ string allButFirst ]
		ifFalse: [ string ]